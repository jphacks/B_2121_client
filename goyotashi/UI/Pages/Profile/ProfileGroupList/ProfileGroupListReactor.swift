//
//  ProfileGroupListReactor.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/26.
//

import ReactorKit

final class ProfileGroupListReactor: Reactor {
    enum GroupListType {
        case myGroups
        case bookmarkedGroups
    }

    enum Action {
        case refresh
    }
    enum Mutation {
        case setGroupCellReactors([GroupSummary])
    }

    struct State {
        var groupCellReactors: [ProfileGroupListCellReactor] = []
    }

    let initialState: State
    private let provider: ServiceProviderType
    private let groupListType: GroupListType

    init(provider: ServiceProviderType, groupListType: GroupListType) {
        self.provider = provider
        self.groupListType = groupListType
        initialState = State()
    }

    func transform(action: Observable<Action>) -> Observable<Action> {
        let groupEventAction = provider.groupService.event
            .flatMap { event -> Observable<Action> in
                switch event {
                case .didCreateGroup:
                    return .just(.refresh)
                }
            }
        let bookmarkEventAction = provider.bookmarkService.event
            .flatMap { [weak self] event -> Observable<Action> in
                switch event {
                case .didUpdateBookmark:
                    if self?.groupListType == .bookmarkedGroups {
                        return .just(.refresh)
                    } else {
                        return .empty()
                    }
                }
            }
        return .merge(
            action,
            groupEventAction,
            bookmarkEventAction
        )
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            return refresh().map(Mutation.setGroupCellReactors)
        }
    }

    func refresh() -> Observable<[GroupSummary]> {
        switch groupListType {
        case .myGroups:
            guard let userId = provider.storeService.authStore.user?.id else { return .empty() }
            return provider.userService.getMyGroups(userId: userId).asObservable()
        case .bookmarkedGroups:
            guard let userId = provider.storeService.authStore.user?.id else { return .empty() }
            return provider.bookmarkService.getBookmarkedGroups(userId: userId).asObservable()
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setGroupCellReactors(groupSummaries):
            state.groupCellReactors = groupSummaries.map { ProfileGroupListCellReactor(groupSummary: $0) }
        }
        return state
    }

    // MARK: Create Reactor Methods
    func createGroupReactor(indexPath: IndexPath) -> GroupReactor {
        let groupId = currentState.groupCellReactors[indexPath.row].currentState.groupSummary.groupId
        return GroupReactor(provider: provider, groupId: groupId)
    }
}

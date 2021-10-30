//
//  RecommendGroupReactor.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/27.
//

import ReactorKit

final class RecommendGroupReactor: Reactor {
    enum Action {
        case refresh
    }
    enum Mutation {
        case setGroupCellReactors([GroupSummary])
    }

    struct State {
        var groupCellReactors: [HomeGroupCellReactor] = []
    }

    let initialState: State
    private let provider: ServiceProviderType

    init(provider: ServiceProviderType) {
        self.provider = provider
        initialState = State()
    }

    func transform(action: Observable<Action>) -> Observable<Action> {
        let userEventAction = provider.userService.event
            .flatMap { event -> Observable<Action> in
                switch event {
                case .didJoinGroup:
                    return .just(.refresh)
                case .didUpdateUser:
                    return .empty()
                }
            }
        return .merge(
            action,
            userEventAction
        )
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            return getGroups().map(Mutation.setGroupCellReactors)
        }
    }

    private func getGroups() -> Observable<[GroupSummary]> {
        return provider.groupService.searchGroup(keyword: "", location: nil).asObservable()
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setGroupCellReactors(groupSummaries):
            state.groupCellReactors = groupSummaries.map { HomeGroupCellReactor(groupSummary: $0) }
        }
        return state
    }

    // MARK: Create Reactor Methods
    func createGroupReactor(indexPath: IndexPath) -> GroupReactor {
        let groupId = currentState.groupCellReactors[indexPath.row].currentState.groupSummary.groupId
        return GroupReactor(provider: provider, groupId: groupId)
    }
}

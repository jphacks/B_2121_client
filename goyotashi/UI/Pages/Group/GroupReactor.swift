//
//  GroupReactor.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/26.
//

import ReactorKit

final class GroupReactor: Reactor {
    enum Action {
        case refresh
        case tapBookmarkButton
    }

    enum Mutation {
        case setGroup(Group)
        case setUsers([User])
        case setRestaurantCellReactors([GroupRestaurant])
        case setIsBookmarked(Bool)
        case setBookmarkApiStatus(APIStatus)
    }

    struct State {
        let groupId: Int64
        var group: Group?
        var users: [User] = []
        var restaurantCellReactors: [GroupRestaurantCellReactor] = []
        var isMember: Bool = false
        var isBookmarked: Bool = false
        var bookmarkApiStatus: APIStatus = .pending
    }

    let initialState: State
    private let provider: ServiceProviderType

    init(provider: ServiceProviderType, groupId: Int64) {
        self.provider = provider
        initialState = State(groupId: groupId)
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            return .merge(
                getGroup().map(Mutation.setGroup),
                getUsers().map(Mutation.setUsers),
                getRestaurants().map(Mutation.setRestaurantCellReactors)
            )
        case .tapBookmarkButton:
            if currentState.bookmarkApiStatus != .pending { return .empty() }
            return .concat(
                .just(.setBookmarkApiStatus(.loading)),
                updateBookmark(currentIsBookmarked: currentState.isBookmarked)
                    .map(Mutation.setIsBookmarked),
                .just(.setBookmarkApiStatus(.pending))
            )
        }
    }

    private func getGroup() -> Observable<Group> {
        let groupId = currentState.groupId
        return provider.groupService.getGroup(id: groupId).asObservable()
    }

    private func getUsers() -> Observable<[User]> {
        let groupId = currentState.groupId
        return provider.groupService.getUsers(groupId: groupId).asObservable()
    }

    private func getRestaurants() -> Observable<[GroupRestaurant]> {
        let groupId = currentState.groupId
        return provider.restaurantService.getRestaurants(groupId: groupId).asObservable()
    }

    private func updateBookmark(currentIsBookmarked: Bool) -> Observable<Bool> {
        if currentIsBookmarked {
            return removeBookmark()
        } else {
            return addBookmark()
        }
    }

    private func addBookmark() -> Observable<Bool> {
        return .just(true)
    }

    private func removeBookmark() -> Observable<Bool> {
        return .just(false)
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setGroup(group):
            state.group = group
        case let .setUsers(users):
            state.users = users
            if let userId = provider.storeService.authStore.user?.id {
                state.isMember = users.map { $0.id }.contains(userId)
            }
        case let .setRestaurantCellReactors(groupRestaurants):
            state.restaurantCellReactors = groupRestaurants.map { GroupRestaurantCellReactor(groupRestaurant: $0) }
        case let .setIsBookmarked(isBookmarked):
            state.isBookmarked = isBookmarked
        case let .setBookmarkApiStatus(apiStatus):
            state.bookmarkApiStatus = apiStatus
        }
        return state
    }

    // MARK: - Create Reactor Methods
    func createOrganizeRestaurantReactor() -> OrganizeRestaurantReactor {
        return OrganizeRestaurantReactor(provider: provider)
    }

    func createEditGroupReactor() -> EditGroupReactor? {
        guard let group = currentState.group else { return nil }
        return EditGroupReactor(provider: provider, group: group)
    }

    func createInviteMemberReactor() -> InviteMemberReactor {
        return InviteMemberReactor(provider: provider)
    }

    func createSearchRestaurantReactor() -> SearchRestaurantReactor {
        return SearchRestaurantReactor(provider: provider)
    }

    func createRestaurantReactor(indexPath: IndexPath) -> RestaurantReactor {
        return RestaurantReactor(provider: provider)
    }

    func memberListReactor() -> MemberListReactor {
        return MemberListReactor()
    }
}

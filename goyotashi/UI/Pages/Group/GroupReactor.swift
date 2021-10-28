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
    }

    enum Mutation {
        case setGroup(Group)
        case setRestaurantCellReactors([GroupRestaurant])
    }

    struct State {
        var group: Group?
        var restaurantCellReactors: [GroupRestaurantCellReactor] = []
        let isMember: Bool = true
    }

    let initialState: State
    private let provider: ServiceProviderType

    init(provider: ServiceProviderType) {
        self.provider = provider
        initialState = State()
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            return .merge(
                getGroup().map(Mutation.setGroup),
                getRestaurants().map(Mutation.setRestaurantCellReactors)
            )
        }
    }

    private func getGroup() -> Observable<Group> {
        return provider.groupService.getGroup(id: "groupId").asObservable()
    }

    private func getRestaurants() -> Observable<[GroupRestaurant]> {
        return provider.restaurantService.getRestaurants(groupId: "groupId").asObservable()
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setGroup(group):
            state.group = group
        case let .setRestaurantCellReactors(groupRestaurants):
            state.restaurantCellReactors = groupRestaurants.map { GroupRestaurantCellReactor(groupRestaurant: $0) }
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

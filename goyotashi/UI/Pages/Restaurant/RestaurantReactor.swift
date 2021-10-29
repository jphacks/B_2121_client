//
//  RestaurantReactor.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/26.
//

import ReactorKit

final class RestaurantReactor: Reactor {
    enum Action {
        case refresh
    }
    enum Mutation {
        case setRestaurant(Restaurant)
        case setGroupCellReactors([RestaurantOtherGroup])
    }

    struct State {
        let restaurantId: Int64
        let groupId: Int64
        var restaurant: Restaurant?
        var groupCellReactors: [RestaurantOtherGroupCellReactor] = []
    }

    let initialState: State
    private let provider: ServiceProviderType

    init(provider: ServiceProviderType, restaurantId: Int64, groupId: Int64) {
        self.provider = provider
        initialState = State(restaurantId: restaurantId, groupId: groupId)
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            return .merge(
                getRestaurant().map(Mutation.setRestaurant),
                getOtherGroups().map(Mutation.setGroupCellReactors)
            )
        }
    }

    private func getRestaurant() -> Observable<Restaurant> {
        return provider.restaurantService.getRestaurant(restaurantId: currentState.restaurantId).asObservable()
    }

    private func getOtherGroups() -> Observable<[RestaurantOtherGroup]> {
        return provider.restaurantService.getOtherGroups(restaurantId: currentState.restaurantId, groupId: currentState.groupId).asObservable()
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setRestaurant(restaurant):
            state.restaurant = restaurant
        case let .setGroupCellReactors(restaurantOtherGroups):
            state.groupCellReactors = restaurantOtherGroups.map { RestaurantOtherGroupCellReactor(restaurantOtherGroup: $0) }
        }
        return state
    }

    // MARK: - Create Reactor Methods
    func createAddRestaurantToGroupReactor() -> AddRestaurantToGroupReactor {
        return AddRestaurantToGroupReactor(provider: provider)
    }

    func createGroupReactor(indexPath: IndexPath) -> GroupReactor {
        let groupId = currentState.groupCellReactors [indexPath.row].currentState.restaurantOtherGroup.groupId
        return GroupReactor(provider: provider, groupId: groupId)
    }
}

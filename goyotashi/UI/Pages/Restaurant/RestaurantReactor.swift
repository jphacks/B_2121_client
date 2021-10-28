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
        var restaurant: Restaurant?
        var groupCellReactors: [RestaurantOtherGroupCellReactor] = []
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
            let restaurantOtherGroups = TestData.restaurantOtherGroups(count: 9)
            return .merge(
                getRestaurant().map(Mutation.setRestaurant),
                .just(Mutation.setGroupCellReactors(restaurantOtherGroups))
            )
        }
    }

    private func getRestaurant() -> Observable<Restaurant> {
        return provider.restaurantService.getRestaurant(restaurantId: "restaurantId").asObservable()
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
}

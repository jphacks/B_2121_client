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
        case setGroupCellReactors([RestaurantOtherGroup])
    }

    struct State {
        let restaurant: Restaurant = TestData.restaurant()
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
            return .just(Mutation.setGroupCellReactors(restaurantOtherGroups))
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
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

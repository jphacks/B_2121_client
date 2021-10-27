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
        case setRestaurantCellReactors([GroupRestaurant])
    }

    struct State {
        var group: Group = TestData.group()
        var restaurantCellReactors: [GroupRestaurantCellReactor] = []
        let isMember: Bool = true
    }

    let initialState: State = State()

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            let groupRestaurants = TestData.groupRestaurants(count: 9)
            return .just(Mutation.setRestaurantCellReactors(groupRestaurants))
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setRestaurantCellReactors(groupRestaurants):
            state.restaurantCellReactors = groupRestaurants.map { GroupRestaurantCellReactor(groupRestaurant: $0) }
        }
        return state
    }

    // MARK: - Create Reactor Methods
    func createOrganizeRestaurantReactor() -> OrganizeRestaurantReactor {
        return OrganizeRestaurantReactor()
    }

    func createEditGroupReactor() -> EditGroupReactor {
        return EditGroupReactor(group: currentState.group)
    }

    func createRestaurantReactor(indexPath: IndexPath) -> RestaurantReactor {
        return RestaurantReactor()
    }
}

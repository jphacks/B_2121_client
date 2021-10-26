//
//  OrganizeRestaurantCellReactor.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/27.
//

import ReactorKit

final class OrganizeRestaurantCellReactor: Reactor {
    enum Action {
        case toggleIsRemovable
    }
    enum Mutation {
        case setIsRemovable(Bool)
    }

    struct State {
        let groupRestaurant: GroupRestaurant
        var isRemovable: Bool = false

        init(groupRestaurant: GroupRestaurant) {
            self.groupRestaurant = groupRestaurant
        }
    }

    let initialState: State

    init(groupRestaurant: GroupRestaurant) {
        initialState = State(groupRestaurant: groupRestaurant)
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .toggleIsRemovable:
            let isRemovable = !currentState.isRemovable
            return .just(.setIsRemovable(isRemovable))
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setIsRemovable(isRemovable):
            state.isRemovable = isRemovable
        }
        return state
    }
}

extension OrganizeRestaurantCellReactor: Equatable {
    static func == (lhs: OrganizeRestaurantCellReactor, rhs: OrganizeRestaurantCellReactor) -> Bool {
        return lhs.currentState.groupRestaurant.restaurantId == rhs.currentState.groupRestaurant.restaurantId
    }
}

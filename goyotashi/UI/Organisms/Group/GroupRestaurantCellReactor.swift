//
//  GroupRestaurantCellReactor.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/26.
//

import ReactorKit

final class GroupRestaurantCellReactor: Reactor {
    enum Action {}
    enum Mutation {}

    struct State {
        let groupRestaurant: GroupRestaurant

        init(groupRestaurant: GroupRestaurant) {
            self.groupRestaurant = groupRestaurant
        }
    }

    let initialState: State

    init(groupRestaurant: GroupRestaurant) {
        initialState = State(groupRestaurant: groupRestaurant)
    }
}

extension GroupRestaurantCellReactor: Equatable {
    static func == (lhs: GroupRestaurantCellReactor, rhs: GroupRestaurantCellReactor) -> Bool {
        return lhs.currentState.groupRestaurant.restaurantId == rhs.currentState.groupRestaurant.restaurantId
    }
}

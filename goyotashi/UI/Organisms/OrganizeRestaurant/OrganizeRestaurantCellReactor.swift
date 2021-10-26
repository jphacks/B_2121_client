//
//  OrganizeRestaurantCellReactor.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/27.
//

import ReactorKit

final class OrganizeRestaurantCellReactor: Reactor {
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

extension OrganizeRestaurantCellReactor: Equatable {
    static func == (lhs: OrganizeRestaurantCellReactor, rhs: OrganizeRestaurantCellReactor) -> Bool {
        return lhs.currentState.groupRestaurant.restaurantId == rhs.currentState.groupRestaurant.restaurantId
    }
}

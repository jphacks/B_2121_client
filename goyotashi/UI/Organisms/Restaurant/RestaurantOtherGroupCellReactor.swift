//
//  RestaurantOtherGroupCellReactor.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/26.
//

import ReactorKit

final class RestaurantOtherGroupCellReactor: Reactor {
    enum Action {}
    enum Mutation {}

    struct State {
        let restaurantOtherGroup: RestaurantOtherGroup
        var description: String {
            return "\(restaurantOtherGroup.restaurantCount)件のお店 / \(restaurantOtherGroup.memberCount)人のメンバー"
        }

        init(restaurantOtherGroup: RestaurantOtherGroup) {
            self.restaurantOtherGroup = restaurantOtherGroup
        }
    }

    let initialState: State

    init(restaurantOtherGroup: RestaurantOtherGroup) {
        initialState = State(restaurantOtherGroup: restaurantOtherGroup)
    }
}

extension RestaurantOtherGroupCellReactor: Equatable {
    static func == (lhs: RestaurantOtherGroupCellReactor, rhs: RestaurantOtherGroupCellReactor) -> Bool {
        return lhs.currentState.restaurantOtherGroup.groupId == rhs.currentState.restaurantOtherGroup.groupId
    }
}

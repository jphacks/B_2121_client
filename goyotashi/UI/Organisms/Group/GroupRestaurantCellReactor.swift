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
        let property: Int = 0
    }

    let initialState: State = State()
}

extension GroupRestaurantCellReactor: Equatable {
    static func == (lhs: GroupRestaurantCellReactor, rhs: GroupRestaurantCellReactor) -> Bool {
        return lhs.currentState.property == rhs.currentState.property
    }
}

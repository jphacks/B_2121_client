//
//  AddRestaurantToGroupCellReactor.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/27.
//

import ReactorKit

final class AddRestaurantToGroupCellReactor: Reactor {
    enum Action {}
    enum Mutation {}

    struct State {
        let property: Int = 0
    }

    let initialState: State = State()
}

extension AddRestaurantToGroupCellReactor: Equatable {
    static func == (lhs: AddRestaurantToGroupCellReactor, rhs: AddRestaurantToGroupCellReactor) -> Bool {
        return lhs.currentState.property == rhs.currentState.property
    }
}

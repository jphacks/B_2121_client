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
        let groupSummary: GroupSummary
    }

    let initialState: State

    init(groupSummary: GroupSummary) {
        initialState = State(groupSummary: groupSummary)
    }
}

extension AddRestaurantToGroupCellReactor: Equatable {
    static func == (lhs: AddRestaurantToGroupCellReactor, rhs: AddRestaurantToGroupCellReactor) -> Bool {
        return lhs.currentState.groupSummary.groupId == rhs.currentState.groupSummary.groupId
    }
}

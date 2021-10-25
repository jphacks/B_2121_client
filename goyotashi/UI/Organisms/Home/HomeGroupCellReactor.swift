//
//  HomeGroupCellReactor.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/25.
//

import ReactorKit

final class HomeGroupCellReactor: Reactor {
    enum Action {}
    enum Mutation {}

    struct State {
        let homeGroup: HomeGroup = TestData.homeGroup()
    }

    let initialState: State = State()
}

extension HomeGroupCellReactor: Equatable {
    static func == (lhs: HomeGroupCellReactor, rhs: HomeGroupCellReactor) -> Bool {
        return lhs.currentState.homeGroup.groupId == rhs.currentState.homeGroup.groupId
    }
}

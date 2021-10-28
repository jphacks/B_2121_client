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
        let groupSummary: GroupSummary
        var description: String {
            return "\(groupSummary.restaurantCount)件のお店 / \(groupSummary.memberCount)人のメンバー"
        }

        init(groupSummary: GroupSummary) {
            self.groupSummary = groupSummary
        }
    }

    let initialState: State

    init(groupSummary: GroupSummary) {
        initialState = State(groupSummary: groupSummary)
    }
}

extension HomeGroupCellReactor: Equatable {
    static func == (lhs: HomeGroupCellReactor, rhs: HomeGroupCellReactor) -> Bool {
        return lhs.currentState.groupSummary.groupId == rhs.currentState.groupSummary.groupId
    }
}

//
//  ProfileGroupListCellReactor.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/26.
//

import ReactorKit

final class ProfileGroupListCellReactor: Reactor {
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

extension ProfileGroupListCellReactor: Equatable {
    static func == (lhs: ProfileGroupListCellReactor, rhs: ProfileGroupListCellReactor) -> Bool {
        return lhs.currentState.groupSummary.groupId == rhs.currentState.groupSummary.groupId
    }
}

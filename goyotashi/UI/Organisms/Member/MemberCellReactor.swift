//
//  MemberCellReactor.swift
//  goyotashi
//
//  Created by 山河絵利奈 on 2021/10/27.
//

import ReactorKit

final class MemberCellReactor: Reactor {
    enum Action {}
    enum Mutation {}

    struct State {
        let member: User

        init(member: User) {
            self.member = member
        }
    }

    let initialState: State

    init(member: User) {
        initialState = State(member: member)
    }
}

extension MemberCellReactor: Equatable {
    static func == (lhs: MemberCellReactor, rhs: MemberCellReactor) -> Bool {
        return lhs.currentState.member.userId == rhs.currentState.member.userId
    }
}

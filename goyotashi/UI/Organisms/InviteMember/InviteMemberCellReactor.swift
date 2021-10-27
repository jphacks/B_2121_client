//
//  InviteMemberCellReactor.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/27.
//

import ReactorKit

final class InviteMemberCellReactor: Reactor {
    enum Action {}
    enum Mutation {}

    struct State {
        let member: User = TestData.user()
    }

    let initialState: State = State()
}

extension InviteMemberCellReactor: Equatable {
    static func == (lhs: InviteMemberCellReactor, rhs: InviteMemberCellReactor) -> Bool {
        return lhs.currentState.member.userId == rhs.currentState.member.userId
    }
}

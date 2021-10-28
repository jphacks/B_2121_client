//
//  MemberListReactor.swift
//  goyotashi
//
//  Created by 山河絵利奈 on 2021/10/27.
//

import ReactorKit

final class MemberListReactor: Reactor {
    enum Action {
    }
    enum Mutation {
        case setMemberCellReactors([User])
    }

    struct State {
        let members: [User] = (0 ..< 4).map { _ in TestData.user() }
        var memberCellReactors: [MemberCellReactor] = []
    }

    let initialState: State = State()

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setMemberCellReactors(members):
            state.memberCellReactors = members.map { MemberCellReactor(member: $0) }
        }
        return state
    }
}

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
        case setGroupName(String)
        case setIsPublic(Bool)
    }

    struct State {
        let members: [User] = (0 ..< 4).map { _ in TestData.user() }
    }

    let initialState: State = State()
}

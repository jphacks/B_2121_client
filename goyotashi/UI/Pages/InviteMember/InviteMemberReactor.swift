//
//  InviteMemberReactor.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/27.
//

import ReactorKit

final class InviteMemberReactor: Reactor {
    enum Action {}
    enum Mutation {}

    struct State {
        let members: [User] = TestData.users(count: 8)
        var memberCellReactors: [InviteMemberCellReactor] = (0 ..< 8).map { _ in InviteMemberCellReactor() }
    }

    let initialState: State = State()
}

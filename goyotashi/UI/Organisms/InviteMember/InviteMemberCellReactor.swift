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

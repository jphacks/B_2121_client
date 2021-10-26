//
//  CreateGroupReactor.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/26.
//

import ReactorKit

final class CreateGroupReactor: Reactor {
    enum Action {}
    enum Mutation {}

    struct State {
        let members: [User] = (0 ..< 4).map { _ in TestData.user() }
    }

    let initialState: State = State()
}

//
//  ProfileReactor.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/26.
//

import ReactorKit

final class ProfileReactor: Reactor {
    enum Action {}
    enum Mutation {}

    struct State {
        let user: User = TestData.user()
    }

    let initialState: State = State()
}

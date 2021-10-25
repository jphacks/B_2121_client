//
//  ProfileGroupListReactor.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/26.
//

import ReactorKit

final class ProfileGroupListReactor: Reactor {
    enum Action {}
    enum Mutation {}

    struct State {
        let groupCellReactors: [ProfileGroupListCellReactor] = TestData.profileGroups(count: 6).map { ProfileGroupListCellReactor(profileGroup: $0) }
    }

    let initialState: State = State()
}

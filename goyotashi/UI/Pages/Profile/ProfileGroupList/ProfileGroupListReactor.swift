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
        let groupCellReactors: [ProfileGroupListCellReactor] = TestData.homeGroups(count: 6).map { ProfileGroupListCellReactor(homeGroup: $0) }
    }

    let initialState: State = State()
}

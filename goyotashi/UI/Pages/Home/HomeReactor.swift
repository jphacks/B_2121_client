//
//  HomeReactor.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/25.
//

import ReactorKit

final class HomeReactor: Reactor {
    enum Action {}
    enum Mutation {}

    struct State {
        let groupCellReactors: [HomeGroupCellReactor] = TestData.homeGroups(count: 6).map { homeGroup in
            HomeGroupCellReactor(homeGroup: homeGroup)
        }
    }

    let initialState: State = State()
}

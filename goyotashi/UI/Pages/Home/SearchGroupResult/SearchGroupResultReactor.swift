//
//  SearchGroupResultReactor.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/27.
//

import ReactorKit

final class SearchGroupResultReactor: Reactor {
    enum Action {}
    enum Mutation {}

    struct State {
        var groupCellReactors: [HomeGroupCellReactor] = TestData.homeGroups(count: 8).map { HomeGroupCellReactor(homeGroup: $0) }
    }

    let initialState: State = State()
}

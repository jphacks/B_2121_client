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
        var groupCellReactors: [HomeGroupCellReactor] = []
    }

    let initialState: State = State()
}

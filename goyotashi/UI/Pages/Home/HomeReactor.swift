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
        let groupCellReactors: [HomeGroupCellReactor] = []
    }

    let initialState: State = State()
}

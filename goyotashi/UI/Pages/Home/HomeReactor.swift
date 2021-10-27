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

    struct State {}

    let initialState: State = State()

    // MARK: - Create Reactor Methods
    func createRecommendGroupReactor() -> RecommendGroupReactor {
        return RecommendGroupReactor()
    }
}

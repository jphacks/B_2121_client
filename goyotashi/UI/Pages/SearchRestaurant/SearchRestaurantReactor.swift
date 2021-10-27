//
//  SearchRestaurantReactor.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/27.
//

import ReactorKit

final class SearchRestaurantReactor: Reactor {
    enum Action {}
    enum Mutation {}

    struct State {
        var keyword: String = ""
    }

    let initialState: State = State()

    // MARK: - Create Reactor Methods
    func createSearchRestaurantResultReactor() -> SearchRestaurantResultReactor {
        return SearchRestaurantResultReactor()
    }
}

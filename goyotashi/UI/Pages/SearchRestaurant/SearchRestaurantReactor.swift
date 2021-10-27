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
        let property: Int = 0
    }

    let initialState: State = State()

    // MARK: - Create Reactor Methods
    func createSearchRestaurantResultReactor() -> SearchRestaurantResultReactor {
        return SearchRestaurantResultReactor()
    }
}

//
//  SearchRestaurantCellReactor.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/27.
//

import ReactorKit

final class SearchRestaurantCellReactor: Reactor {
    enum Action {}
    enum Mutation {}

    struct State {
        let restaurant: Restaurant = TestData.restaurant()
    }

    let initialState: State = State()
}

extension SearchRestaurantCellReactor: Equatable {
    static func == (lhs: SearchRestaurantCellReactor, rhs: SearchRestaurantCellReactor) -> Bool {
        return lhs.currentState.restaurant.id == rhs.currentState.restaurant.id
    }
}

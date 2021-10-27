//
//  SearchRestaurantResultReactor.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/27.
//

import ReactorKit

final class SearchRestaurantResultReactor: Reactor {
    enum Action {}
    enum Mutation {}

    struct State {
        let restaurantCellReactors: [SearchRestaurantCellReactor] = (0 ..< 9).map { _ in SearchRestaurantCellReactor() }
    }

    let initialState: State = State()
}

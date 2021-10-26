//
//  RestaurantReactor.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/26.
//

import ReactorKit

final class RestaurantReactor: Reactor {
    enum Action {}
    enum Mutation {}

    struct State {
        let restaurant: Restaurant = TestData.restaurant()
        var groupCellReactors: [RestaurantOtherGroupCellReactor] = TestData.restaurantOtherGroups(count: 9).map { RestaurantOtherGroupCellReactor(restaurantOtherGroup: $0) }
    }

    let initialState: State = State()
}

//
//  GroupReactor.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/26.
//

import ReactorKit

final class GroupReactor: Reactor {
    enum Action {}
    enum Mutation {}

    struct State {
        let restaurantCellReactors: [GroupRestaurantCellReactor] = (0 ..< 5).map { _ in
            GroupRestaurantCellReactor()
        }
    }

    let initialState: State = State()
}

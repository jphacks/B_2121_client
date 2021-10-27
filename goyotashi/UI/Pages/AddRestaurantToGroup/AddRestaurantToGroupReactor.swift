//
//  AddRestaurantToGroupReactor.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/27.
//

import ReactorKit

final class AddRestaurantToGroupReactor: Reactor {
    enum Action {}
    enum Mutation {}

    struct State {
        let property: Int = 0
    }

    let initialState: State = State()
}

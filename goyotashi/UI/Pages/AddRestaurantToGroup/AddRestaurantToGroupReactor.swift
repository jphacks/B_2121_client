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
        let groupCellReactors: [AddRestaurantToGroupCellReactor] = (0 ..< 9).map { _ in AddRestaurantToGroupCellReactor() }
    }

    let initialState: State
    private let provider: ServiceProviderType

    init(provider: ServiceProviderType) {
        self.provider = provider
        initialState = State()
    }
}

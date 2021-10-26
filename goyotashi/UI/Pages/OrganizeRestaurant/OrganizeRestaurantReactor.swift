//
//  OrganizeRestaurantReactor.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/27.
//

import ReactorKit

final class OrganizeRestaurantReactor: Reactor {
    enum Action {
        case didSelectItem(IndexPath)
    }
    enum Mutation {}

    struct State {
        var restaurantCellReactors: [OrganizeRestaurantCellReactor] = TestData.groupRestaurants(count: 9).map { OrganizeRestaurantCellReactor(groupRestaurant: $0) }
    }

    let initialState: State = State()

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .didSelectItem(indexPath):
            currentState.restaurantCellReactors[indexPath.row].action.onNext(.toggleIsRemovable)
            return .empty()
        }
    }
}

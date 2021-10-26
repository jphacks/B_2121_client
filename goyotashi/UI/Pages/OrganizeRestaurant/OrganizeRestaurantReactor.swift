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
        case remove
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
        case .remove:
            let restaurants: [GroupRestaurant] = currentState.restaurantCellReactors
                .filter {
                    $0.currentState.isRemovable == true
                }
                .map { $0.currentState.groupRestaurant }
            return .empty()
        }
    }
}

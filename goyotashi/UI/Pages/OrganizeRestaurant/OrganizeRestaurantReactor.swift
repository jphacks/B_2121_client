//
//  OrganizeRestaurantReactor.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/27.
//

import ReactorKit

final class OrganizeRestaurantReactor: Reactor {
    enum Action {
        case refresh
        case didSelectItem(IndexPath)
        case remove
    }
    enum Mutation {}

    struct State {
        var restaurantCellReactors: [OrganizeRestaurantCellReactor] = []
    }

    let initialState: State
    private let provider: ServiceProviderType

    init(provider: ServiceProviderType) {
        self.provider = provider
        initialState = State()
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            return .empty()
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

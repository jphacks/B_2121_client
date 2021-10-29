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
    enum Mutation {
        case setRestaurantCellReactors([GroupRestaurant])
    }

    struct State {
        var restaurantCellReactors: [OrganizeRestaurantCellReactor] = []
        let groupId: Int64
    }

    let initialState: State
    private let provider: ServiceProviderType

    init(provider: ServiceProviderType, groupId: Int64) {
        self.provider = provider
        initialState = State(groupId: groupId)
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            return getGroupRestaurants().map(Mutation.setRestaurantCellReactors)
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

    private func getGroupRestaurants() -> Observable<[GroupRestaurant]> {
        return provider.restaurantService.getRestaurants(groupId: currentState.groupId).asObservable()
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setRestaurantCellReactors(groupRestaurants):
            state.restaurantCellReactors = groupRestaurants.map { OrganizeRestaurantCellReactor(groupRestaurant: $0) }
        }
        return state
    }
}

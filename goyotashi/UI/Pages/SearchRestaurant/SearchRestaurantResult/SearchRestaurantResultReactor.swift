//
//  SearchRestaurantResultReactor.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/27.
//

import ReactorKit

final class SearchRestaurantResultReactor: Reactor {
    enum Action {
        case search(String)
    }
    enum Mutation {
        case setRestaurantCellReactors([Restaurant])
    }

    struct State {
        var restaurantCellReactors: [SearchRestaurantCellReactor] = []
    }

    let initialState: State
    private let provider: ServiceProviderType

    init(provider: ServiceProviderType) {
        self.provider = provider
        initialState = State()
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .search(keyword):
            return search(keyword: keyword)
                .map(Mutation.setRestaurantCellReactors)
        }
    }

    private func search(keyword: String) -> Observable<[Restaurant]> {
        return provider.restaurantService.searchRestaurants(keyword: keyword, geoPoint: nil).asObservable()
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setRestaurantCellReactors(restaurants):
            state.restaurantCellReactors = restaurants.map { SearchRestaurantCellReactor(restaurant: $0) }
        }
        return state
    }
}

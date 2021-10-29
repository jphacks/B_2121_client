//
//  SearchRestaurantResultReactor.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/27.
//

import ReactorKit
import Foundation

final class SearchRestaurantResultReactor: Reactor {
    enum Action {
        case search(String)
        case didSelectItem(IndexPath)
    }
    enum Mutation {
        case setRestaurantCellReactors([Restaurant])
        case didAdd(Void)
        case setApiStatus(APIStatus)
    }

    struct State {
        var apiStatus: APIStatus = .pending
        var restaurantCellReactors: [SearchRestaurantCellReactor] = []
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
        case let .search(keyword):
            return search(keyword: keyword)
                .map(Mutation.setRestaurantCellReactors)
        case let .didSelectItem(path):
            let restaurantId = getRestaurantCellReactor(indexPath: path).currentState.restaurant.id
            return addRestaurant(restaurantId: restaurantId)
                .map(Mutation.didAdd)
                .catchError { _ in
                    return .just(.setApiStatus(.failed))
                }
        }
    }

    private func search(keyword: String) -> Observable<[Restaurant]> {
        return provider.restaurantService.searchRestaurants(keyword: keyword, geoPoint: nil).asObservable()
    }

    private func addRestaurant(restaurantId: Int64) -> Observable<Void> {
        return provider.restaurantService.addRestaurantToGroup(restaurantId: restaurantId, groupId: currentState.groupId)
            .asObservable()
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setRestaurantCellReactors(restaurants):
            state.restaurantCellReactors = restaurants.map { SearchRestaurantCellReactor(restaurant: $0) }
        case .didAdd:
            state.apiStatus = .succeeded
        // TODO: ???
        //                provider.restaurantService.event.onNext(.didDelete)
        case let .setApiStatus(apiStatus):
            state.apiStatus = apiStatus
        }
        return state
    }

    func getRestaurantCellReactor(indexPath: IndexPath) -> SearchRestaurantCellReactor {
        return self.currentState.restaurantCellReactors[indexPath.row]
    }
}

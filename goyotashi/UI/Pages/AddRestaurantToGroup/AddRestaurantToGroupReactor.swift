//
//  AddRestaurantToGroupReactor.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/27.
//

import ReactorKit

final class AddRestaurantToGroupReactor: Reactor {
    enum Action {
        case refresh
        case didSelectItem(IndexPath)
    }
    enum Mutation {
        case setGroupCellReactors([GroupSummary])
        case didAdd(Void)
        case setApiStatus(APIStatus)
    }

    struct State {
        var apiStatus: APIStatus = .pending
        var groupCellReactors: [AddRestaurantToGroupCellReactor] = []
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
        case .refresh:
            return refresh().map(Mutation.setGroupCellReactors)
        case let .didSelectItem(path):
            let restaurantId = getRestaurantCellReactor(indexPath: path).currentState.restaurant.id
            return addRestaurant(restaurantId: restaurantId)
                .map(Mutation.didAdd)
                .catchError { _ in
                    return .just(.setApiStatus(.failed))
                }
        }
    }

    private func refresh() -> Observable<[GroupSummary]> {
        guard let userId = provider.storeService.authStore.user?.id else { return .empty() }
        return provider.userService.getMyGroups(userId: userId).asObservable()
    }

    private func addRestaurant(restaurantId: Int64) -> Observable<Void> {
        return provider.restaurantService.addRestaurantToGroup(restaurantId: restaurantId, groupId: currentState.groupId)
            .asObservable()
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setGroupCellReactors(groupSummaries):
            state.groupCellReactors = groupSummaries.map { AddRestaurantToGroupCellReactor(groupSummary: $0) }
        case .didAdd:
            state.apiStatus = .succeeded
            provider.restaurantService.event.onNext(.didAdd)
        case let .setApiStatus(apiStatus):
            state.apiStatus = apiStatus
        }
        return state
    }

    func getRestaurantCellReactor(indexPath: IndexPath) -> SearchRestaurantCellReactor {
        return self.currentState.restaurantCellReactors[indexPath.row]
    }
}

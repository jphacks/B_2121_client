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
        case didItemSelect(IndexPath)
    }
    enum Mutation {
        case setGroupCellReactors([GroupSummary])
        case setApiStatus(APIStatus)
    }

    struct State {
        var groupCellReactors: [AddRestaurantToGroupCellReactor] = []
        let restaurantId: Int64
        var apiStatus: APIStatus = .pending

        init(restaurantId: Int64) {
            self.restaurantId = restaurantId
        }
    }

    let initialState: State
    private let provider: ServiceProviderType

    init(provider: ServiceProviderType, restaurantId: Int64) {
        self.provider = provider
        initialState = State(restaurantId: restaurantId)
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            return refresh().map(Mutation.setGroupCellReactors)
        case let .didItemSelect(indexPath):
            if currentState.apiStatus != .pending { return .empty() }
            let groupId = currentState.groupCellReactors[indexPath.row].currentState.groupSummary.groupId
            return .concat(
                .just(.setApiStatus(.loading)),
                addRestaurant(groupId: groupId)
                    .map { _ in .setApiStatus(.succeeded) }
                    .catchError { error in
                        logger.error(error)
                        return .just(Mutation.setApiStatus(.failed))
                    },
                .just(.setApiStatus(.pending))
            )
        }
    }

    private func refresh() -> Observable<[GroupSummary]> {
        guard let userId = provider.storeService.authStore.user?.id else { return .empty() }
        return provider.userService.getMyGroups(userId: userId).asObservable()
    }

    private func addRestaurant(groupId: Int64) -> Observable<Void> {
        return provider.restaurantService.addRestaurantToGroup(restaurantId: currentState.restaurantId, groupId: groupId)
            .asObservable()
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setGroupCellReactors(groupSummaries):
            state.groupCellReactors = groupSummaries.map { AddRestaurantToGroupCellReactor(groupSummary: $0) }
        case let .setApiStatus(apiStatus):
            state.apiStatus = apiStatus
        }
        return state
    }
}

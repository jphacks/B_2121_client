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
    }
    enum Mutation {
        case setGroupCellReactors([GroupSummary])
    }

    struct State {
        var groupCellReactors: [AddRestaurantToGroupCellReactor] = []
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
            return refresh().map(Mutation.setGroupCellReactors)
        }
    }

    private func refresh() -> Observable<[GroupSummary]> {
        guard let userId = provider.storeService.authStore.user?.id else { return .empty() }
        return provider.userService.getMyGroups(userId: userId).asObservable()
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setGroupCellReactors(groupSummaries):
            state.groupCellReactors = groupSummaries.map { AddRestaurantToGroupCellReactor(groupSummary: $0) }
        }
        return state
    }
}

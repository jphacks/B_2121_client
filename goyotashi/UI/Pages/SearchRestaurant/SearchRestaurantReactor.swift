//
//  SearchRestaurantReactor.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/27.
//

import ReactorKit

final class SearchRestaurantReactor: Reactor {
    enum Action {
        case updateKeyword(String?)
    }
    enum Mutation {
        case setKeyword(String)
    }

    struct State {
        var keyword: String = ""
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
        case let .updateKeyword(keyword):
            guard let keyword = keyword else { return .empty() }
            return .just(.setKeyword(keyword))
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setKeyword(keyword):
            state.keyword = keyword
        }
        return state
    }

    // MARK: - Create Reactor Methods
    func createSearchRestaurantResultReactor() -> SearchRestaurantResultReactor {
        return SearchRestaurantResultReactor(provider: provider, groupId: currentState.groupId)
    }
}

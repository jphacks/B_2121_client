//
//  HomeReactor.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/25.
//

import ReactorKit

final class HomeReactor: Reactor {
    enum Action {
        case updateKeyword(String?)
    }
    enum Mutation {
        case setKeyword(String)
    }

    struct State {
        var keyword: String = ""
        var pageType: PageType = .recommendGroup
    }

    let initialState: State = State()

    // MARK: - Create Reactor Methods
    func createRecommendGroupReactor() -> RecommendGroupReactor {
        return RecommendGroupReactor()
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
}

extension HomeReactor {
    enum PageType {
        case recommendGroup
        case searchGroupResult
    }
}

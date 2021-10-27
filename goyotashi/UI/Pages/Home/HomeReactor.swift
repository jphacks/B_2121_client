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
        case didStartSearch
    }
    enum Mutation {
        case setKeyword(String)
        case setPageType(PageType)
    }

    struct State {
        var keyword: String = ""
        var pageType: PageType = .recommendGroup
    }

    let initialState: State = State()

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .updateKeyword(keyword):
            guard let keyword = keyword else { return .empty() }
            return .just(.setKeyword(keyword))
        case .didStartSearch:
            return .just(.setPageType(.searchGroupResult))
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setKeyword(keyword):
            state.keyword = keyword
        case let .setPageType(pageType):
            state.pageType = pageType
        }
        return state
    }

    // MARK: - Create Reactor Methods
    func createRecommendGroupReactor() -> RecommendGroupReactor {
        return RecommendGroupReactor()
    }

    func createSearchGroupResultReactor() -> SearchGroupResultReactor {
        return SearchGroupResultReactor()
    }
}

extension HomeReactor {
    enum PageType {
        case recommendGroup
        case searchGroupResult
    }
}

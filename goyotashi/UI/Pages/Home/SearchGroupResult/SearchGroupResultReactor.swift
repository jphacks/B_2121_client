//
//  SearchGroupResultReactor.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/27.
//

import ReactorKit

final class SearchGroupResultReactor: Reactor {
    enum Action {
        case search(String)
    }
    enum Mutation {
        case setGroupCellReactors([HomeGroup])
    }

    struct State {
        var groupCellReactors: [HomeGroupCellReactor] = TestData.homeGroups(count: 8).map { HomeGroupCellReactor(homeGroup: $0) }
    }

    let initialState: State = State()

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .search(keyword):
            return search(keyword: keyword)
                .map(Mutation.setGroupCellReactors)
        }
    }

    private func search(keyword: String) -> Observable<[HomeGroup]> {
        return .just(TestData.homeGroups(count: Int.random(in: 0 ..< 7)))
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setGroupCellReactors(homeGroups):
            state.groupCellReactors = homeGroups.map { HomeGroupCellReactor(homeGroup: $0) }
        }
        return state
    }
}

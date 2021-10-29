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
        case setGroupCellReactors([GroupSummary])
    }

    struct State {
        var groupCellReactors: [HomeGroupCellReactor] = []
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
                .map(Mutation.setGroupCellReactors)
        }
    }

    private func search(keyword: String) -> Observable<[GroupSummary]> {
        return provider.groupService.searchGroup(keyword: keyword, location: nil).asObservable()
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setGroupCellReactors(groupSummaries):
            state.groupCellReactors = groupSummaries.map { HomeGroupCellReactor(groupSummary: $0) }
        }
        return state
    }

    func createGroupReactor(indexPath: IndexPath) -> GroupReactor {
        let groupId = currentState.groupCellReactors[indexPath.row].currentState.groupSummary.groupId
        return GroupReactor(provider: provider, groupId: groupId)
    }
}

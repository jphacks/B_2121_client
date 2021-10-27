//
//  RecommendGroupReactor.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/27.
//

import ReactorKit

final class RecommendGroupReactor: Reactor {
    enum Action {
        case refresh
    }
    enum Mutation {
        case setGroupCellReactors([HomeGroup])
    }

    struct State {
        var groupCellReactors: [HomeGroupCellReactor] = []
    }

    let initialState: State = State()

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            let homeGroups = TestData.homeGroups(count: 6)
            return .just(Mutation.setGroupCellReactors(homeGroups))
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setGroupCellReactors(homeGroups):
            state.groupCellReactors = homeGroups.map { HomeGroupCellReactor(homeGroup: $0) }
        }
        return state
    }

    // MARK: Create Reactor Methods
    func createGroupReactor(indexPath: IndexPath) -> GroupReactor {
        return GroupReactor()
    }
}

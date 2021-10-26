//
//  ProfileGroupListReactor.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/26.
//

import ReactorKit

final class ProfileGroupListReactor: Reactor {
    enum Action {
        case refresh
    }
    enum Mutation {
        case setGroupCellReactors([ProfileGroup])
    }

    struct State {
        var groupCellReactors: [ProfileGroupListCellReactor] = []
    }

    let initialState: State = State()

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            let profileGroups = TestData.profileGroups(count: 8)
            return .just(Mutation.setGroupCellReactors(profileGroups))
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setGroupCellReactors(profileGroups):
            state.groupCellReactors = profileGroups.map { ProfileGroupListCellReactor(profileGroup: $0) }
        }
        return state
    }
}

//
//  CreateGroupReactor.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/26.
//

import ReactorKit

final class CreateGroupReactor: Reactor {
    enum Action {
        case updateGroupName(String?)
    }
    enum Mutation {
        case setGroupName(String?)
    }

    struct State {
        var groupName: String?
        let members: [User] = (0 ..< 4).map { _ in TestData.user() }
    }

    let initialState: State = State()

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .updateGroupName(name):
            return .just(Mutation.setGroupName(name))
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setGroupName(name):
            state.groupName = name
        }
        return state
    }
}

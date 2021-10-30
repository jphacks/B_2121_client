//
//  JoinGroupReactor.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/30.
//

import ReactorKit

final class JoinGroupReactor: Reactor {
    enum Action {
        case updateInvitationCode(String?)
    }
    enum Mutation {
        case setInvitationCode(String)
    }

    struct State {
        var invitationCode: String = ""
    }

    let initialState: State = State()

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .updateInvitationCode(code):
            guard let code = code else { return .empty() }
            return .just(.setInvitationCode(code))
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setInvitationCode(code):
            state.invitationCode = code
        }
        return state
    }
}

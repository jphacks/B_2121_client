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
        case join
    }
    enum Mutation {
        case setInvitationCode(String)
        case setApiStatus(APIStatus)
    }

    struct State {
        var invitationCode: String = ""
        var apiStatus: APIStatus = .pending
    }

    let initialState: State = State()

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .updateInvitationCode(code):
            guard let code = code else { return .empty() }
            return .just(.setInvitationCode(code))
        case .join:
            if currentState.apiStatus != .pending { return .empty() }
            return .concat(
                .just(.setApiStatus(.loading)),
                join().map { _ in .setApiStatus(.succeeded) },
                .just(.setApiStatus(.pending))
            )
        }
    }

    private func join() -> Observable<Void> {
        return .empty()
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setInvitationCode(code):
            state.invitationCode = code
            logger.debug(code)
        case let .setApiStatus(apiStatus):
            state.apiStatus = apiStatus
        }
        return state
    }
}

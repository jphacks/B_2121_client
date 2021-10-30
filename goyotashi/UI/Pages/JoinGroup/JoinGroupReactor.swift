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

    let initialState: State
    private let provider: ServiceProviderType

    init(provider: ServiceProviderType) {
        self.provider = provider
        initialState = State()
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .updateInvitationCode(code):
            guard let code = code else { return .empty() }
            return .just(.setInvitationCode(code))
        case .join:
            if currentState.apiStatus != .pending { return .empty() }
            return .concat(
                .just(.setApiStatus(.loading)),
                join().map { _ in .setApiStatus(.succeeded) }
                    .catchError { error in
                        logger.error(error)
                        return .just(.setApiStatus(.failed))
                    },
                .just(.setApiStatus(.pending))
            )
        }
    }

    private func join() -> Observable<Void> {
        let token = currentState.invitationCode
        return provider.userService.joinGroup(token: token).asObservable()
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

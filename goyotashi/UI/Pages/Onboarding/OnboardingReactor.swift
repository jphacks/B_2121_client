//
//  OnboardingReactor.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/30.
//

import ReactorKit

final class OnboardingReactor: Reactor {
    enum Action {
        case createUser
        case updateName(String?)
    }
    enum Mutation {
        case setName(String)
    }

    struct State {
        var name: String = ""
    }

    let initialState: State
    private let provider: ServiceProviderType

    init(provider: ServiceProviderType) {
        self.provider = provider
        initialState = State()
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .createUser:
            return .empty()
        case let .updateName(name):
            guard let name = name else { return .empty() }
            return .just(.setName(name))
        }
    }

    private func createUser() -> Observable<User> {
        return provider.userService.createUser().asObservable()
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setName(name):
            state.name = name
            logger.debug(name)
        }
        return state
    }
}

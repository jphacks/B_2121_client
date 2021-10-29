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
        case startApp
    }
    enum Mutation {
        case setUser(User)
    }

    struct State {
        var user: User?
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
            return createUser().map(Mutation.setUser)
        case let .updateName(name):
            guard let name = name else { return .empty() }
            return updateUserName(name: name).map(Mutation.setUser)
        case .startApp:
            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                sceneDelegate.setMainPage(type: .tabBar)
            }
            return .empty()
        }
    }

    private func createUser() -> Observable<User> {
        return provider.userService.createUser().asObservable()
    }

    private func updateUserName(name: String) -> Observable<User> {
        return provider.userService.updateMyName(name: name).asObservable()
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setUser(user):
            state.user = user
            logger.debug("user: \(user)")
        }
        return state
    }
}

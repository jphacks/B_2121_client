//
//  ProfileEditReactor.swift
//  goyotashi
//
//  Created by 山河絵利奈 on 2021/10/29.
//

import ReactorKit

final class ProfileEditReactor: Reactor {
    enum Action {
        case refresh
        case update
        case updateName(String?)
    }
    enum Mutation {
        case setUser(User)
        case didUpdate(User)
        case setApiStatus(APIStatus)
        case setUserName(String?)
    }

    struct State {
        var name: String?
        var profileImageUrl: String?
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
        case .refresh:
            return refresh().map(Mutation.setUser)
        case .update:
            if currentState.apiStatus != .pending { return .empty() }
            return .concat(
                .just(.setApiStatus(.loading)),
                updateUser()
                    .map(Mutation.didUpdate)
                    .catchError { _ in
                        return .just(.setApiStatus(.failed))
                    }
            )
        case let .updateName(name):
            return .just(Mutation.setUserName(name))
        }
    }

    private func refresh() -> Observable<User> {
        provider.userService.getMyProfile().asObservable()
    }

    private func updateUser() -> Observable<User> {
        print("update user!!!")
        if let name = currentState.name {
            return provider.userService.updateMyName(name: name).asObservable()
        }
        return .empty()
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setUser(user):
            state.name = user.name
            state.profileImageUrl = user.profileImageUrl
        case let .didUpdate(user):
            logger.verbose("user update: \(user)")
            state.apiStatus = .succeeded
            provider.userService.event.onNext(.didUpdateUser)
        case let .setApiStatus(apiStatus):
            state.apiStatus = apiStatus
        case let .setUserName(name):
            state.name = name
        }
        return state
    }
}

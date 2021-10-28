//
//  ProfileReactor.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/26.
//

import ReactorKit

final class ProfileReactor: Reactor {
    enum Action {
        case refresh
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
        case .refresh:
            return refresh().map(Mutation.setUser)
        }
    }

    private func refresh() -> Observable<User> {
        provider.userService.getMyProfile().asObservable()
    }

    // MARK: - Create Reactor Methods
    func createProfileGroupListReactor() -> ProfileGroupListReactor {
        return ProfileGroupListReactor(provider: provider)
    }

    func createCreateGroupReactor() -> CreateGroupReactor {
        return CreateGroupReactor(provider: provider)
    }
}

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

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setUser(user):
            state.user = user
        }
        return state
    }

    // MARK: - Create Reactor Methods
    func createProfileGroupListReactor(groupListType: ProfileGroupListReactor.GroupListType) -> ProfileGroupListReactor {
        return ProfileGroupListReactor(provider: provider, groupListType: groupListType)
    }

    func createCreateGroupReactor() -> CreateGroupReactor {
        return CreateGroupReactor(provider: provider)
    }

    func createProfileEditReactor() -> ProfileEditReactor {
        return ProfileEditReactor(provider: provider)
    }
}

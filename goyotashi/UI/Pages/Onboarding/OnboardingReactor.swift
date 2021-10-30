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
        case updateUser(User)
        case setGroup(Group)
        case updateUserName(String)
    }

    struct State {
        var user: User?
        var group: Group?
        var canStartApp: Bool {
            didUpdateName
        }
        var didUpdateName: Bool = false
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
            return .just(Mutation.updateUserName(name))
        case .startApp:
            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                sceneDelegate.setMainPage(type: .tabBar)
            }
            return .merge(
                updateUserName().map(Mutation.updateUser),
                createGroup().map(Mutation.setGroup)
            )
        }
    }

    private func createUser() -> Observable<User> {
        return provider.userService.createUser().asObservable()
    }

    private func createGroup() -> Observable<Group> {
        if let user = currentState.user {
            let userName = user.name
            let name = groupName()
            let description: String
            description = "\(userName)さんのはじめてのグループです！"
            return provider.groupService.createGroup(name: name, description: description, isPublic: true).asObservable()
        } else {
            return .empty()
        }
    }

    private func updateUserName() -> Observable<User> {
        if let user = currentState.user {
            return provider.userService.updateMyName(name: user.name).asObservable()
        } else {
            return .empty()
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setUser(user):
            state.user = user
            logger.debug("user: \(user)")
        case let .updateUser(user):
            logger.debug("updated user: \(user)")
            provider.userService.event.onNext(.didUpdateUser)
        case let .setGroup(group):
            state.group = group
            logger.debug("group: \(group)")
            provider.userService.event.onNext(.didUpdateUser)
        case let .updateUserName(name):
            if let user = state.user {
                let newUser = User(
                    id: user.id,
                    name: name,
                    profileImageUrl: user.profileImageUrl)
                state.user = newUser
                state.didUpdateName = true
                logger.debug("updated user name: \(newUser)")
            }
        }
        return state
    }

    private func groupName() -> String {
        let groupNames: [String] = [
            "そこまでランチして委員会",
            "美味しいものたくさん食べたい！",
            "唯一無二の絶品グルメ",
            "そこまでモーニングして委員会",
            "はじめてのグループ",
            "食欲にはあらがえない",
            "何かおいしい物食べたい",
            "行列のできるお店まとめ",
            "海鮮しか勝たん",
            "ラーメンしか勝たん",
            "ほかとは一味違うグループ",
            "定番の人気スポット",
            "はじめてのグループ"
        ]
        return groupNames.randomElement() ?? ""
    }
}

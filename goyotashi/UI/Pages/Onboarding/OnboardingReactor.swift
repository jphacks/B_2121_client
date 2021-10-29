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
        case setGroup(Group)
    }

    struct State {
        var user: User?
        var group: Group?
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
            return .merge(
                updateUserName(name: name).map(Mutation.setUser),
                createGroup(userName: name).map(Mutation.setGroup)
            )
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

    private func createGroup(userName: String) -> Observable<Group> {
        let name = groupName()
        let description: String
        description = "\(userName)さんのはじめてのグループです！"
        return provider.groupService.createGroup(name: name, description: description, isPublic: true).asObservable()
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
        case let .setGroup(group):
            state.group = group
            logger.debug("group: \(group)")
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

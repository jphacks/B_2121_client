//
//  EditGroupReactor.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/27.
//

import ReactorKit

final class EditGroupReactor: Reactor {
    enum Action {
        case updateGroupName(String?)
        case updateGroupDescription(String?)
        case updateIsOnPrivacySwitch(Bool)
    }
    enum Mutation {
        case setGroupName(String)
        case setGroupDescription(String)
        case setIsPublic(Bool)
    }

    struct State {
        let uneditedGroup: Group
        var groupName: String
        var groupDescription: String
        let members: [User]
        var isPublic: Bool

        init(group: Group) {
            self.uneditedGroup = group
            self.groupName = group.name
            self.groupDescription = group.description
            self.members = group.members
            self.isPublic = group.isPublic
        }
    }

    let initialState: State
    private let provider: ServiceProviderType

    init(provider: ServiceProviderType, group: Group) {
        self.provider = provider
        initialState = State(group: group)
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .updateGroupName(name):
            guard let name = name else { return .empty() }
            return .just(Mutation.setGroupName(name))
        case let .updateGroupDescription(description):
            guard let description = description else { return .empty() }
            return .just(Mutation.setGroupDescription(description))
        case let .updateIsOnPrivacySwitch(isOn):
            return .just(Mutation.setIsPublic(isOn))
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setGroupName(name):
            state.groupName = name
        case let .setGroupDescription(description):
            state.groupDescription = description
        case let .setIsPublic(isPublic):
            state.isPublic = isPublic
        }
        return state
    }
}

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
        case save
    }
    enum Mutation {
        case setGroupName(String)
        case setGroupDescription(String)
        case setIsPublic(Bool)
        case didUpdate(Group)
        case setApiStatus(APIStatus)
    }

    struct State {
        let uneditedGroup: Group
        let groupId: Int64
        var groupName: String
        var groupDescription: String
        let members: [User]
        var isPublic: Bool
        var apiStatus: APIStatus = .pending

        init(group: Group) {
            self.uneditedGroup = group
            self.groupName = group.name
            self.groupDescription = group.description
            self.members = group.members
            self.isPublic = group.isPublic
            self.groupId = group.id
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
        case .save:
            if currentState.apiStatus != .pending { return .empty() }
            return .concat(
                .just(.setApiStatus(.loading)),
                saveGroup()
                    .map(Mutation.didUpdate)
                    .catchError { _ in
                        return .just(.setApiStatus(.failed))
                    }
            )
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
        case let .didUpdate(group):
            logger.verbose("group update: \(group)")
            state.apiStatus = .succeeded
            provider.groupService.event.onNext(.didUpdateGroup)
        case let .setApiStatus(apiStatus):
            state.apiStatus = apiStatus
        }
        return state
    }

    func saveGroup() -> Observable<Group> {
        return provider.groupService.updateGroup(id: currentState.groupId, name: currentState.groupName, description: currentState.groupDescription).asObservable()
    }
}

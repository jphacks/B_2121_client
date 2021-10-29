//
//  CreateGroupReactor.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/26.
//

import ReactorKit

final class CreateGroupReactor: Reactor {
    enum Action {
        case updateGroupName(String?)
        case updateGroupDescription(String?)
        case updateIsOnPrivacySwitch(Bool)
        case create
    }
    enum Mutation {
        case setGroupName(String)
        case setGroupDescription(String)
        case setIsPublic(Bool)
        case didCreate(Group)
    }

    struct State {
        var groupName: String = ""
        var groupDescription: String = ""
        let members: [User] = (0 ..< 4).map { _ in TestData.user() }
        var isPublic: Bool = false
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
        case let .updateGroupName(name):
            guard let name = name else { return .empty() }
            return .just(Mutation.setGroupName(name))
        case let .updateGroupDescription(description):
            guard let description = description else { return .empty() }
            return .just(Mutation.setGroupDescription(description))
        case let .updateIsOnPrivacySwitch(isOn):
            return .just(Mutation.setIsPublic(isOn))
        case .create:
            return createGroup().map(Mutation.didCreate)
        }
    }

    private func createGroup() -> Observable<Group> {
        provider.groupService.createGroup(name: currentState.groupName, description: currentState.groupDescription, isPublic: currentState.isPublic).asObservable()
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
        case let .didCreate(group):
            // TODO: Notify that a group has been created
            logger.verbose("group created: \(group)")
        }
        return state
    }
}

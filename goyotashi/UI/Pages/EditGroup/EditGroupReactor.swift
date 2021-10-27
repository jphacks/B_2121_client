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
        case updateIsOnPrivacySwitch(Bool)
    }
    enum Mutation {
        case setGroupName(String)
        case setIsPublic(Bool)
    }

    struct State {
        var groupName: String = ""
        let members: [User] = (0 ..< 4).map { _ in TestData.user() }
        var isPublic: Bool = false
    }

    let initialState: State = State()

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .updateGroupName(name):
            guard let name = name else { return .empty() }
            return .just(Mutation.setGroupName(name))
        case let .updateIsOnPrivacySwitch(isOn):
            return .just(Mutation.setIsPublic(isOn))
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setGroupName(name):
            state.groupName = name
        case let .setIsPublic(isPublic):
            state.isPublic = isPublic
        }
        return state
    }
}

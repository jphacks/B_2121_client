//
//  ProfileGroupListCellReactor.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/26.
//

import ReactorKit

final class ProfileGroupListCellReactor: Reactor {
    enum Action {}
    enum Mutation {}

    struct State {
        let profileGroup: ProfileGroup
        var description: String {
            return "\(profileGroup.restaurantCount)件のお店 / \(profileGroup.memberCount)人のメンバー"
        }

        init(profileGroup: ProfileGroup) {
            self.profileGroup = profileGroup
        }
    }

    let initialState: State

    init(profileGroup: ProfileGroup) {
        initialState = State(profileGroup: profileGroup)
    }
}

extension ProfileGroupListCellReactor: Equatable {
    static func == (lhs: ProfileGroupListCellReactor, rhs: ProfileGroupListCellReactor) -> Bool {
        return lhs.currentState.profileGroup.groupId == rhs.currentState.profileGroup.groupId
    }
}

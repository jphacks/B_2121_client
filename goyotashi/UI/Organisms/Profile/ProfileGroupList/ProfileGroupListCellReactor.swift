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
        let homeGroup: HomeGroup
        var description: String {
            return "\(homeGroup.restaurantCount)件のお店 / \(homeGroup.memberCount)人のメンバー"
        }

        init(homeGroup: HomeGroup) {
            self.homeGroup = homeGroup
        }
    }

    let initialState: State

    init(homeGroup: HomeGroup) {
        initialState = State(homeGroup: homeGroup)
    }
}

extension ProfileGroupListCellReactor: Equatable {
    static func == (lhs: ProfileGroupListCellReactor, rhs: ProfileGroupListCellReactor) -> Bool {
        return lhs.currentState.homeGroup.groupId == rhs.currentState.homeGroup.groupId
    }
}

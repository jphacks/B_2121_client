//
//  RestaurantOtherGroupCellReactor.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/26.
//

import ReactorKit

final class RestaurantOtherGroupCellReactor: Reactor {
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

extension RestaurantOtherGroupCellReactor: Equatable {
    static func == (lhs: RestaurantOtherGroupCellReactor, rhs: RestaurantOtherGroupCellReactor) -> Bool {
        return lhs.currentState.profileGroup.groupId == rhs.currentState.profileGroup.groupId
    }
}

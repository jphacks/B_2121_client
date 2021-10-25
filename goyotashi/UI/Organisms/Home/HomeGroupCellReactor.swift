//
//  HomeGroupCellReactor.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/25.
//

import ReactorKit

final class HomeGroupCellReactor: Reactor {
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

extension HomeGroupCellReactor: Equatable {
    static func == (lhs: HomeGroupCellReactor, rhs: HomeGroupCellReactor) -> Bool {
        return lhs.currentState.homeGroup.groupId == rhs.currentState.homeGroup.groupId
    }
}

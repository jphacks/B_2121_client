//
//  InviteMemberReactor.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/27.
//

import ReactorKit

final class InviteMemberReactor: Reactor {
    enum Action {
        case tapInvitationLinkButton
    }
    enum Mutation {
        case setInvitationToken(String)
    }

    struct State {
        let members: [User] = TestData.users(count: 8)
        var memberCellReactors: [InviteMemberCellReactor] = (0 ..< 8).map { _ in InviteMemberCellReactor() }
        var invitationToken: String = ""
    }

    let initialState: State
    private let provider: ServiceProviderType

    init(provider: ServiceProviderType) {
        self.provider = provider
        initialState = State()
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .tapInvitationLinkButton:
            return .empty()
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setInvitationToken(token):
            state.invitationToken = token
        }
        return state
    }
}

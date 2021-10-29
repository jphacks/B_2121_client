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
        case setGetTokenApiStatus(APIStatus)
    }

    struct State {
        let groupId: Int64
        let members: [User] = TestData.users(count: 8)
        var memberCellReactors: [InviteMemberCellReactor] = []
        var invitationToken: String = ""
        var getTokenApiStatus: APIStatus = .pending

        init(groupId: Int64) {
            self.groupId = groupId
        }
    }

    let initialState: State
    private let provider: ServiceProviderType

    init(provider: ServiceProviderType, groupId: Int64) {
        self.provider = provider
        initialState = State(groupId: groupId)
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .tapInvitationLinkButton:
            if currentState.getTokenApiStatus != .pending { return .empty() }
            return .concat(
                .just(.setGetTokenApiStatus(.loading)),
                getToken()
                    .map(Mutation.setInvitationToken),
                .just(.setGetTokenApiStatus(.pending))
            )
        }
    }

    private func getToken() -> Observable<String> {
        let groupId = currentState.groupId
        return provider.groupService.getGroupToken(groupId: groupId).asObservable()
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setInvitationToken(token):
            state.invitationToken = token
            state.getTokenApiStatus = .succeeded
            logger.debug("token: \(token)")
        case let .setGetTokenApiStatus(apiStatus):
            state.getTokenApiStatus = apiStatus
        }
        return state
    }
}

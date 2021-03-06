//
//  UserService.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/28.
//

import RxSwift
import OpenAPIClient

protocol UserServiceType {
    // MARK: - Event
    var event: PublishSubject<UserEvent> { get }

    func createUser() -> Single<User>
    func getMyProfile() -> Single<User>
    func updateMyName(name: String) -> Single<User>
    func getMyGroups(userId: Int64) -> Single<[GroupSummary]>
    func joinGroup(token: String) -> Single<Void>
}

final class UserService: BaseService, UserServiceType {
    // MARK: - Event
    let event: PublishSubject<UserEvent> = PublishSubject<UserEvent>()

    func createUser() -> Single<User> {
        // TODO: remove name "Gohan Daisuki"
        // TODO: remove vendor: .anonymous
        let request = CreateUserRequest(name: "Gohan Daisuki", vendor: .anonymous)
        return UserAPI.newUser(createUserRequest: request)
            .map { (response: CreateUserResponse) in
                let authInfo: AuthInfo = AuthInfo(token: response.authInfo.token, vendor: response.authInfo.vendor.rawValue)
                let user: User = User(id: response.user.id, name: response.user.name, profileImageUrl: response.user.profileImageUrl ?? "")
                self.provider.storeService.authStore.authInfo = authInfo
                self.provider.storeService.authStore.user = user
                OpenAPIClient.customHeaders["Authorization"] = authInfo.token

                logger.verbose("success to create user: \(user)")
                logger.verbose("authInfo is \(authInfo)")
                return user
            }
            .asSingle()
    }

    func getMyProfile() -> Single<User> {
        // TODO: save communityCount
        // TODO: save bookmarkCount
        return UserAPI.getMyProfile()
            .map { (userDetail: UserDetail) in
                return User(id: userDetail.id, name: userDetail.name, profileImageUrl: userDetail.profileImageUrl)
            }
            .asSingle()
    }

    func getMyGroups(userId: Int64) -> Single<[GroupSummary]> {
        return UserAPI.listUserCommunities(id: userId)
            .map { (response: ListUserCommunityResponse) in
                guard let communities = response.communities else { return [] }
                let groups = communities.map { community in
                    return GroupSummary(
                        groupId: community.id,
                        groupName: community.name,
                        groupDescription: community.description,
                        restaurantCount: community.numRestaurant,
                        memberCount: community.numUser,
                        imageUrls: community.imageUrls
                    )
                }
                return groups
            }
            .asSingle()
    }

    func updateMyName(name: String) -> Single<User> {
        let request = PutUserMeRequest(name: name)
        return UserAPI.userMePut(putUserMeRequest: request)
            .map { resp in
                return User(
                    id: resp.id,
                    name: resp.name,
                    profileImageUrl: resp.profileImageUrl
                )
            }
            .asSingle()
    }

    func joinGroup(token: String) -> Single<Void> {
        let request = JoinCommunityRequest(inviteToken: token)
        return UserAPI.userMeCommunitiesPost(joinCommunityRequest: request)
            .asSingle()
    }
}

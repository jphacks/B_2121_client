//
//  UserService.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/28.
//

import RxSwift
import OpenAPIClient

protocol UserServiceType {
    func createUser() -> Single<Void>
    func getMyProfile() -> Single<User>
    func getMyGroups(userId: Int64) -> Single<[GroupSummary]>
}

final class UserService: BaseService, UserServiceType {
    func createUser() -> Single<Void> {
        // TODO: remove name "Gohan Daisuki"
        // TODO: remove vendor: .anonymous
        let request = CreateUserRequest(name: "Gohan Daisuki", vendor: .anonymous)
        return UserAPI.newUser(createUserRequest: request)
            .map { (response: CreateUserResponse) in
                let authInfo: AuthInfo = AuthInfo(token: response.authInfo.token, vendor: response.authInfo.vendor.rawValue)
                let user: User = User(id: response.user.id, name: response.user.name, profileImageUrl: response.user.profileImageUrl ?? "")
                self.provider.storeService.authStore.authInfo = authInfo
                self.provider.storeService.authStore.user = user

                logger.verbose("success to create user: \(user)")
                logger.verbose("authInfo is \(authInfo)")
                return
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
}

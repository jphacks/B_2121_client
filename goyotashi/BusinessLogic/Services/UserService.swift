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
    func getMyGroups() -> Single<[GroupSummary]>
}

final class UserService: BaseService, UserServiceType {
    func createUser() -> Single<Void> {
        let request = CreateUserRequest(name: "Gohan Daisuki", vendor: .anonymous)
        return UserAPI.newUser(createUserRequest: request)
            .map { (response: CreateUserResponse) in
                let authInfo: AuthInfo = AuthInfo(token: response.authInfo.token, vendor: response.authInfo.vendor.rawValue)
                let user: User = User(id: response.user.id, name: response.user.name, profileImageUrl: response.user.profileImageUrl ?? "")
                self.provider.storeService.authStore.authInfo = authInfo
                self.provider.storeService.authStore.user = user

                print("response: \(response)")
                return
            }
            .asSingle()
    }

    func getMyProfile() -> Single<User> {
        return UserAPI.getMyProfile()
            .map { (userDetail: UserDetail) in
                return User(id: userDetail.id, name: userDetail.name, profileImageUrl: userDetail.profileImageUrl)
            }
            .asSingle()
    }

    func getMyGroups() -> Single<[GroupSummary]> {
        return .just(TestData.groupSummaries(count: 9))
    }
}

//
//  UserService.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/28.
//

import RxSwift

protocol UserServiceType {
    func createUser() -> Single<Void>
    func getMyProfile() -> Single<User>
}

final class UserService: BaseService, UserServiceType {
    func createUser() -> Single<Void> {
        return .just(())
    }

    func getMyProfile() -> Single<User> {
        return .just(TestData.user())
    }
}

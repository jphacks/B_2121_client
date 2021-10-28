//
//  UserService.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/28.
//

import RxSwift

protocol UserServiceType {
    func createUser() -> Single<Void>
}

final class UserService: BaseService, UserServiceType {
    func createUser() -> Single<Void> {
        return .just(())
    }
}

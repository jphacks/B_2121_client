//
//  AuthStore.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/29.
//

import SwiftyUserDefaults

protocol AuthStoreType {
    var authInfo: AuthInfo? { get set }
    var user: User? { get set }
}

class AuthStore: AuthStoreType {
    var authInfo: AuthInfo? {
        get { return Defaults[\.authInfo] }
        set { Defaults[\.authInfo] = newValue }
    }

    var user: User? {
        get { return Defaults[\.user] }
        set { Defaults[\.user] = newValue }
    }
}

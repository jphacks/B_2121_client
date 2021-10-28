//
//  DefaultKeys.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/29.
//

import SwiftyUserDefaults

extension DefaultsKeys {
    // MARK: - Auth
    var authInfo: DefaultsKey<AuthInfo?> { return .init("authInfo", defaultValue: nil) }
    var user: DefaultsKey<User?> { return .init("user", defaultValue: nil) }
}

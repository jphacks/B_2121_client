//
//  AuthInfo.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/29.
//

import SwiftyUserDefaults

struct AuthInfo {
    let token: String
    let vendor: String
}

extension AuthInfo: Codable, DefaultsSerializable {}

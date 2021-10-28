//
//  User.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/26.
//

import SwiftyUserDefaults

struct User {
    let id: Int64
    let name: String
    let profileImageUrl: String
}

extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
}

extension User: Codable, DefaultsSerializable {}

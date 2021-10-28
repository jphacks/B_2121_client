//
//  Group.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/26.
//

struct Group {
    let id: Int64
    let name: String
    let description: String
    let memberCount: Int
    let restaurantCount: Int
    let members: [User]
    let isPublic: Bool
}

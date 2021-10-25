//
//  TestData.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/25.
//

import Foundation

struct TestData {
    static func homeGroup() -> HomeGroup {
        return HomeGroup(
            groupId: randomString(length: 8),
            groupName: "CAMPHOR-",
            restaurantCount: Int.random(in: 4 ..< 16),
            memberCount: Int.random(in: 4 ..< 32),
            imageUrls: []
        )
    }

    private static func randomString(length: Int) -> String {
        let letters: NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        var randomString = ""

        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        return randomString
    }
}

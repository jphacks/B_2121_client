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
            imageUrls: restaurantImageUrlStrings()
        )
    }

    static func homeGroups(count: Int) -> [HomeGroup] {
        return (0 ..< count).map { _ in
            homeGroup()
        }
    }

    static func profileGroup() -> ProfileGroup {
        return ProfileGroup(
            groupId: randomString(length: 8),
            groupName: "CAMPHOR-",
            restaurantCount: Int.random(in: 4 ..< 16),
            memberCount: Int.random(in: 4 ..< 32),
            imageUrls: restaurantImageUrlStrings()
        )
    }

    static func profileGroups(count: Int) -> [ProfileGroup] {
        return (0 ..< count).map { _ in
            profileGroup()
        }
    }

    static func user() -> User {
        return User(
            userId: randomString(length: 8),
            userName: "KoukiNAGATA",
            profileImageUrl: "https://avatars.githubusercontent.com/u/38304075?v=4"
        )
    }

    // MARK: - Private Functions
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

    private static func restaurantImageUrlString() -> String {
        let urlStrings = [
            "https://tabelog.com/imgview/original?id=r65552151702596",
            "https://tabelog.com/imgview/original?id=r11654158141187",
            "https://tabelog.com/imgview/original?id=r4602762283989",
            "https://tabelog.com/imgview/original?id=r0603049448770",
            "https://tabelog.com/imgview/original?id=r95060153709981",
            "https://tabelog.com/imgview/original?id=r20765157345324",
            "https://tabelog.com/imgview/original?id=r40533131033962"
        ]
        return urlStrings[Int.random(in: 0 ..< urlStrings.count)]
    }

    private static func restaurantImageUrlStrings() -> [String] {
        let size = Int.random(in: 3 ..< 6)
        return (0 ..< size).map { _ in restaurantImageUrlString() }
    }
}

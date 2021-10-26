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

    static func groupRestaurant() -> GroupRestaurant {
        return GroupRestaurant(
            restaurantId: randomString(length: 8),
            imageUrl: restaurantImageUrlString(),
            restaurantName: "和洋キッチン松之助"
        )
    }

    static func groupRestaurants(count: Int) -> [GroupRestaurant] {
        return (0 ..< count).map { _ in
            groupRestaurant()
        }
    }

    static func group() -> Group {
        let memberCount = Int.random(in: 1 ..< 5)
        let members = (0 ..< memberCount).map { _ in user() }
        return Group(
            id: randomString(length: 8),
            name: "CAMPHOR-",
            description: "CAMPHOR-カンファーは京都のIT系学生コミュニティです。エンジニアリング・デザイン・プロダクト開発などへの関心を共通点とする、様々なバックグラウンドを持つ学生が集まっています。",
            memberCount: memberCount,
            restaurantCount: Int.random(in: 3 ..< 16),
            members: members
        )
    }

    static func restaurantOtherGroup() -> RestaurantOtherGroup {
        return RestaurantOtherGroup(
            groupId: randomString(length: 8),
            groupName: "そこまでランチして委員会",
            restaurantCount: 9,
            memberCount: 3,
            imageUrls: restaurantImageUrlStrings()
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
        let size = Int.random(in: 3 ..< 7)
        return (0 ..< size).map { _ in restaurantImageUrlString() }
    }
}

//
//  TestData.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/25.
//

import Foundation

struct TestData {
    static func user() -> User {
        return User(
            id: randomInt64(),
            name: "KoukiNAGATA",
            profileImageUrl: "https://avatars.githubusercontent.com/u/38304075?v=4"
        )
    }

    static func users(count: Int) -> [User] {
        return (0 ..< count).map { _ in
            user()
        }
    }

    static func groupRestaurant() -> GroupRestaurant {
        return GroupRestaurant(
            restaurantId: randomInt(),
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
            id: randomInt64(),
            name: "CAMPHOR-",
            description: "CAMPHOR-カンファーは京都のIT系学生コミュニティです。エンジニアリング・デザイン・プロダクト開発などへの関心を共通点とする、様々なバックグラウンドを持つ学生が集まっています。",
            memberCount: memberCount,
            restaurantCount: Int.random(in: 3 ..< 16),
            members: members,
            isPublic: Bool.random()
        )
    }

    static func restaurantOtherGroup() -> RestaurantOtherGroup {
        return RestaurantOtherGroup(
            groupId: randomInt(),
            groupName: "そこまでランチして委員会",
            restaurantCount: 9,
            memberCount: 3,
            imageUrls: restaurantImageUrlStrings()
        )
    }

    static func restaurantOtherGroups(count: Int) -> [RestaurantOtherGroup] {
        return (0 ..< count).map { _ in
            restaurantOtherGroup()
        }
    }

    static func location() -> Location {
        return Location(latitude: 35.020669, longitude: 135.77871)
    }

    static func restaurant() -> Restaurant {
        return Restaurant(
            id: randomInt64(),
            imageUrl: restaurantImageUrlString(),
            name: "とんかつおくだ",
            description: "定食・食堂・ハンバーグ・洋食",
            address: "京都府京都市左京区田中里ノ前町1西野ビル1F",
            phoneNumber: "075-702-1724",
            openingHours: "[月〜土]\n11:30〜14:30(L.O. 14:00)\n17:30〜22:30(L.O. 22:00)",
            location: location()
        )
    }

    static func restaurants(count: Int) -> [Restaurant] {
        return (0 ..< count).map { _ in restaurant() }
    }

    static func groupSummary() -> GroupSummary {
        return GroupSummary(
            groupId: randomInt64(),
            groupName: "CAMPHOR-",
            groupDescription: "CAMPHOR-カンファーは京都のIT系学生コミュニティです。エンジニアリング・デザイン・プロダクト開発などへの関心を共通点とする、様々なバックグラウンドを持つ学生が集まっています。",
            restaurantCount: Int.random(in: 2 ..< 16),
            memberCount: Int.random(in: 4 ..< 16),
            imageUrls: restaurantImageUrlStrings()
        )
    }

    static func groupSummaries(count: Int) -> [GroupSummary] {
        return (0 ..< count).map { _ in groupSummary() }
    }

    // MARK: - Private Functions
    private static func randomInt() -> Int {
        return Int.random(in: Int.min ..< Int.max)
    }

    private static func randomInt64() -> Int64 {
        return Int64.random(in: Int64.min ..< Int64.max)
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

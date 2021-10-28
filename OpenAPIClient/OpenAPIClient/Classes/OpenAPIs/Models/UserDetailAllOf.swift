//
// UserDetailAllOf.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct UserDetailAllOf: Codable, Hashable {

    public var communityCount: Int
    public var bookmarkCount: Int

    public init(communityCount: Int, bookmarkCount: Int) {
        self.communityCount = communityCount
        self.bookmarkCount = bookmarkCount
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case communityCount = "community_count"
        case bookmarkCount = "bookmark_count"
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(communityCount, forKey: .communityCount)
        try container.encode(bookmarkCount, forKey: .bookmarkCount)
    }
}


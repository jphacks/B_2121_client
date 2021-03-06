//
// CommunityDetailAllOf.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct CommunityDetailAllOf: Codable, Hashable {

    public var userCount: Int
    public var numRestaurant: Int?

    public init(userCount: Int, numRestaurant: Int? = nil) {
        self.userCount = userCount
        self.numRestaurant = numRestaurant
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case userCount = "user_count"
        case numRestaurant = "num_restaurant"
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(userCount, forKey: .userCount)
        try container.encodeIfPresent(numRestaurant, forKey: .numRestaurant)
    }
}


//
// Comment.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

/** Private comments for a restaurant */
public struct Comment: Codable, Hashable {

    public var communityId: Int64?
    public var restaurantId: Int64?
    public var body: String?
    /** Updated date and time */
    public var updatedAt: Date?

    public init(communityId: Int64? = nil, restaurantId: Int64? = nil, body: String? = nil, updatedAt: Date? = nil) {
        self.communityId = communityId
        self.restaurantId = restaurantId
        self.body = body
        self.updatedAt = updatedAt
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case communityId = "community_id"
        case restaurantId = "restaurant_id"
        case body
        case updatedAt = "updated_at"
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(communityId, forKey: .communityId)
        try container.encodeIfPresent(restaurantId, forKey: .restaurantId)
        try container.encodeIfPresent(body, forKey: .body)
        try container.encodeIfPresent(updatedAt, forKey: .updatedAt)
    }
}


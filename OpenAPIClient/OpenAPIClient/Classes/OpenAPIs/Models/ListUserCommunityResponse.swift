//
// ListUserCommunityResponse.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct ListUserCommunityResponse: Codable, Hashable {

    public var communities: [Community]?
    public var beginCursor: Int?
    public var endCursor: Int?
    public var hasPrevious: Bool?
    public var hasNext: Bool?

    public init(communities: [Community]? = nil, beginCursor: Int? = nil, endCursor: Int? = nil, hasPrevious: Bool? = nil, hasNext: Bool? = nil) {
        self.communities = communities
        self.beginCursor = beginCursor
        self.endCursor = endCursor
        self.hasPrevious = hasPrevious
        self.hasNext = hasNext
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case communities
        case beginCursor = "begin_cursor"
        case endCursor = "end_cursor"
        case hasPrevious = "has_previous"
        case hasNext = "has_next"
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(communities, forKey: .communities)
        try container.encodeIfPresent(beginCursor, forKey: .beginCursor)
        try container.encodeIfPresent(endCursor, forKey: .endCursor)
        try container.encodeIfPresent(hasPrevious, forKey: .hasPrevious)
        try container.encodeIfPresent(hasNext, forKey: .hasNext)
    }
}


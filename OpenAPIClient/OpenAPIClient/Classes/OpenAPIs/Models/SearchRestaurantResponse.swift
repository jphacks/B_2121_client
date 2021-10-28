//
// SearchRestaurantResponse.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct SearchRestaurantResponse: Codable, Hashable {

    public var beginCursor: Int?
    public var endCursor: Int?
    public var hasPrevious: Bool?
    public var hasNext: Bool?
    public var restaurants: [Restaurant]?

    public init(beginCursor: Int? = nil, endCursor: Int? = nil, hasPrevious: Bool? = nil, hasNext: Bool? = nil, restaurants: [Restaurant]? = nil) {
        self.beginCursor = beginCursor
        self.endCursor = endCursor
        self.hasPrevious = hasPrevious
        self.hasNext = hasNext
        self.restaurants = restaurants
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case beginCursor = "begin_cursor"
        case endCursor = "end_cursor"
        case hasPrevious = "has_previous"
        case hasNext = "has_next"
        case restaurants
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(beginCursor, forKey: .beginCursor)
        try container.encodeIfPresent(endCursor, forKey: .endCursor)
        try container.encodeIfPresent(hasPrevious, forKey: .hasPrevious)
        try container.encodeIfPresent(hasNext, forKey: .hasNext)
        try container.encodeIfPresent(restaurants, forKey: .restaurants)
    }
}


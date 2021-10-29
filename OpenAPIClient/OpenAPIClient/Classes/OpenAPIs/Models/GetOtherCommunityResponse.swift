//
// GetOtherCommunityResponse.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct GetOtherCommunityResponse: Codable, Hashable {

    public var communities: [Community]

    public init(communities: [Community]) {
        self.communities = communities
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case communities
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(communities, forKey: .communities)
    }
}

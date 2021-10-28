//
// Community.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

/** Goyotashi community */
public struct Community: Codable, Hashable {

    public var id: Int64
    public var name: String
    public var description: String?
    public var location: Location?

    public init(id: Int64, name: String, description: String? = nil, location: Location? = nil) {
        self.id = id
        self.name = name
        self.description = description
        self.location = location
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case name
        case description
        case location
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(location, forKey: .location)
    }
}


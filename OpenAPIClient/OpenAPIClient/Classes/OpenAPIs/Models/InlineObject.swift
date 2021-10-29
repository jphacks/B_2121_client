//
// InlineObject.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct InlineObject: Codable, Hashable {

    public var name: String
    public var description: String
    public var location: Location

    public init(name: String, description: String, location: Location) {
        self.name = name
        self.description = description
        self.location = location
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case name
        case description
        case location
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        try container.encode(location, forKey: .location)
    }
}


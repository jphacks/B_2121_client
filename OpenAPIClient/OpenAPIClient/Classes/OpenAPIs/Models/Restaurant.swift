//
// Restaurant.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

/** Restaurant */
public struct Restaurant: Codable, Hashable {

    public var id: Int64
    public var name: String
    public var location: Location
    public var imageUrl: String?

    public init(id: Int64, name: String, location: Location, imageUrl: String? = nil) {
        self.id = id
        self.name = name
        self.location = location
        self.imageUrl = imageUrl
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case name
        case location
        case imageUrl = "image_url"
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(location, forKey: .location)
        try container.encodeIfPresent(imageUrl, forKey: .imageUrl)
    }
}


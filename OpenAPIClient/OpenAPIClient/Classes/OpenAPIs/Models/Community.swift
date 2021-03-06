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
    public var description: String
    public var location: Location
    public var imageUrls: [String]
    public var numUser: Int
    public var numRestaurant: Int

    public init(id: Int64, name: String, description: String, location: Location, imageUrls: [String], numUser: Int, numRestaurant: Int) {
        self.id = id
        self.name = name
        self.description = description
        self.location = location
        self.imageUrls = imageUrls
        self.numUser = numUser
        self.numRestaurant = numRestaurant
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case name
        case description
        case location
        case imageUrls
        case numUser = "num_user"
        case numRestaurant = "num_restaurant"
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        try container.encode(location, forKey: .location)
        try container.encode(imageUrls, forKey: .imageUrls)
        try container.encode(numUser, forKey: .numUser)
        try container.encode(numRestaurant, forKey: .numRestaurant)
    }
}


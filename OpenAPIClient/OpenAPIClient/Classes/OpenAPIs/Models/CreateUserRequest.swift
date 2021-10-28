//
// CreateUserRequest.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct CreateUserRequest: Codable, Hashable {

    public var name: String
    public var vendor: AuthVendor

    public init(name: String, vendor: AuthVendor) {
        self.name = name
        self.vendor = vendor
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case name
        case vendor
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(vendor, forKey: .vendor)
    }
}


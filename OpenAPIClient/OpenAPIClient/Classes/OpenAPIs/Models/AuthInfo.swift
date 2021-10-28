//
// AuthInfo.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct AuthInfo: Codable, Hashable {

    public var vendor: AuthVendor
    public var token: String

    public init(vendor: AuthVendor, token: String) {
        self.vendor = vendor
        self.token = token
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case vendor
        case token
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(vendor, forKey: .vendor)
        try container.encode(token, forKey: .token)
    }
}

//
//  GeoPoint.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/29.
//

struct GeoPoint {
    let latitude: Double
    let longitude: Double
}

extension GeoPoint: Equatable {
    static func == (lhs: GeoPoint, rhs: GeoPoint) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

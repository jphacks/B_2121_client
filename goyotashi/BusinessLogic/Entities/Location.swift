//
//  Location.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/26.
//

struct Location {
    let latitude: Double
    let longitude: Double
}

extension Location: Equatable {
    static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

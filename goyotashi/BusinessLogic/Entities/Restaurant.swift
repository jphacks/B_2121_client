//
//  Restaurant.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/26.
//

struct Restaurant {
    let id: Int64
    let imageUrl: String?
    let name: String
    let description: String
    let address: String
    let phoneNumber: String
    let openingHours: String
    let location: Location
}

extension Restaurant: Equatable {
    static func == (lhs: Restaurant, rhs: Restaurant) -> Bool {
        return lhs.id == rhs.id
    }
}

//
//  RestaurantService.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/28.
//

import RxSwift
import OpenAPIClient

protocol RestaurantServiceType {
    func getRestaurants(groupId: Int64) -> Single<[GroupRestaurant]>
    func addRestaurantToGroup(restaurantId: String, groupId: String) -> Single<Void>
    func removeRestaurantFromGroup(restaurantId: String, groupId: String) -> Single<Void>
    func searchRestaurants(keyword: String, geoPoint: GeoPoint?) -> Single<[Restaurant]>
    func getRestaurant(restaurantId: Int64) -> Single<Restaurant>
    func getOtherGroups(restaurantId: Int64) -> Single<[RestaurantOtherGroup]>
}

final class RestaurantService: BaseService, RestaurantServiceType {
    func getRestaurants(groupId: Int64) -> Single<[GroupRestaurant]> {
        let id = Int(groupId)
        return RestaurantAPI.listCommunityRestaurants(id: id)
            .map { (response: ListCommunityRestaurantsResponse) in
                guard let responseRestaurants = response.restaurants else { return [] }
                let restaurants = responseRestaurants.map { restaurant in
                    GroupRestaurant(
                        restaurantId: restaurant.id,
                        imageUrl: restaurant.imageUrl ?? "",
                        restaurantName: restaurant.name
                    )
                }
                return restaurants
            }
            .asSingle()
    }

    func addRestaurantToGroup(restaurantId: String, groupId: String) -> Single<Void> {
        return .just(())
    }

    func removeRestaurantFromGroup(restaurantId: String, groupId: String) -> Single<Void> {
        return .just(())
    }

    func searchRestaurants(keyword: String, geoPoint: GeoPoint?) -> Single<[Restaurant]> {
        // TODO: get description
        // TODO: get address
        // TODO: get phoneNumber
        // TODO: get openingHours
        return RestaurantAPI.searchRestaurants(keyword: keyword, after: nil, centerLat: geoPoint?.latitude, centerLng: geoPoint?.longitude)
            .map { (response: SearchRestaurantResponse) -> [Restaurant] in
                guard let responseRestaurants = response.restaurants else { return [] }
                let restaurants = responseRestaurants.map { restaurant in
                    return Restaurant(
                        id: restaurant.id,
                        imageUrl: restaurant.imageUrl,
                        name: restaurant.name,
                        description: "",
                        address: "",
                        phoneNumber: "",
                        openingHours: "",
                        geoPoint: GeoPoint(latitude: restaurant.location.lat, longitude: restaurant.location.lng)
                    )
                }
                return restaurants
            }
            .asSingle()
    }

    func getRestaurant(restaurantId: Int64) -> Single<Restaurant> {
        return RestaurantAPI.restaurantIdGet(id: restaurantId)
            .map {restaurant in
                return Restaurant(
                    id: restaurant.id,
                    imageUrl: restaurant.imageUrl,
                    name: restaurant.name,
                    description: "",
                    address: "",
                    phoneNumber: "",
                    openingHours: "",
                    geoPoint: GeoPoint(latitude: restaurant.location.lat, longitude: restaurant.location.lng)
                )
            }
            .asSingle()
    }

    func getOtherGroups(restaurantId: Int64) -> Single<[RestaurantOtherGroup]> {
        return .just(TestData.restaurantOtherGroups(count: 5))
    }
}

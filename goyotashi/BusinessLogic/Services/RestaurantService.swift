//
//  RestaurantService.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/28.
//

import RxSwift

protocol RestaurantServiceType {
    func getRestaurants(groupId: String) -> Single<[GroupRestaurant]>
    func addRestaurantToGroup(restaurantId: String, groupId: String) -> Single<Void>
    func removeRestaurantFromGroup(restaurantId: String, groupId: String) -> Single<Void>
    func searchRestaurants(keyword: String, location: Location?) -> Single<[Restaurant]>
}

final class RestaurantService: BaseService, RestaurantServiceType {
    func getRestaurants(groupId: String) -> Single<[GroupRestaurant]> {
        return .just(TestData.groupRestaurants(count: 9))
    }

    func addRestaurantToGroup(restaurantId: String, groupId: String) -> Single<Void> {
        return .just(())
    }

    func removeRestaurantFromGroup(restaurantId: String, groupId: String) -> Single<Void> {
        return .just(())
    }

    func searchRestaurants(keyword: String, location: Location?) -> Single<[Restaurant]> {
        return .just(TestData.restaurants(count: 8))
    }
}

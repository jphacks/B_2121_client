//
//  ServiceProvider.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/28.
//

protocol ServiceProviderType: AnyObject {
    var userService: UserServiceType { get }
    var restaurantService: RestaurantServiceType { get }
    var groupService: GroupServiceType { get }
    var bookmarkService: BookmarkServiceType { get }
}

final class ServiceProvider: ServiceProviderType {
    lazy var userService: UserServiceType = UserService(provider: self)
    lazy var restaurantService: RestaurantServiceType = RestaurantService(provider: self)
    lazy var groupService: GroupServiceType = GroupService(provider: self)
    lazy var bookmarkService: BookmarkServiceType = BookmarkService(provider: self)
}

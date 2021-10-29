//
//  GroupService.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/28.
//

import RxSwift
import OpenAPIClient

protocol GroupServiceType {
    // MARK: - Event
    var event: PublishSubject<GroupEvent> { get }

    func createGroup(name: String, description: String, isPublic: Bool) -> Single<Group>
    func searchGroup(keyword: String, location: Location?) -> Single<[GroupSummary]>
    func getGroup(id: Int64) -> Single<Group>
    func getUsers(groupId: Int64) -> Single<[User]>
    func updateGroup(id: Int64, name: String, description: String) -> Single<Group>
}

final class GroupService: BaseService, GroupServiceType {
    // MARK: - Event
    let event: PublishSubject<GroupEvent> = PublishSubject<GroupEvent>()

    func createGroup(name: String, description: String, isPublic: Bool) -> Single<Group> {
        // TODO: replace geoPoint with user location
        // TODO: send isPublic
        // TODO: get members
        // TODO: get isPublic
        let geoPoint = TestData.camphorGeoPoint()
        let request = CreateCommunityRequest(
            name: name,
            description: description,
            location: Location(lat: geoPoint.latitude, lng: geoPoint.longitude)
        )
        return CommunityAPI.newCommunity(createCommunityRequest: request)
            .map { (community: Community) in
                Group(
                    id: community.id,
                    name: community.name,
                    description: community.description,
                    memberCount: community.numUser,
                    restaurantCount: community.numRestaurant,
                    members: [],
                    isPublic: isPublic,
                    imageUrls: community.imageUrls
                )
            }
            .asSingle()
    }

    func searchGroup(keyword: String, location: Location?) -> Single<[GroupSummary]> {
        return CommunityAPI.searchCommunities(keyword: keyword)
            .map { (response: SearchCommunityResponse) in
                guard let communities = response.communities else { return [] }
                let groups = communities.map { community in
                    return GroupSummary(
                        groupId: community.id,
                        groupName: community.name,
                        groupDescription: community.description,
                        restaurantCount: community.numRestaurant,
                        memberCount: community.numUser,
                        imageUrls: community.imageUrls
                    )
                }
                return groups
            }
            .asSingle()
    }

    func getGroup(id: Int64) -> Single<Group> {
        // INFO: You can get the list of members from other requests.
        let groupId = Int(id)
        return CommunityAPI.getCommunityById(id: groupId)
            .map { (community: Community) in
                Group(
                    id: community.id,
                    name: community.name,
                    description: community.description,
                    memberCount: community.numUser,
                    restaurantCount: community.numRestaurant,
                    members: [],
                    isPublic: true,
                    imageUrls: community.imageUrls
                )
            }
            .asSingle()
    }

    func getUsers(groupId: Int64) -> Single<[User]> {
        let id = Int(groupId)
        return CommunityAPI.listUsersOfCommunity(id: id)
            .map { (response: ListCommunityUsersResponse) in
                guard let responseUsers = response.users else { return [] }
                let users = responseUsers.map { user in
                    User(
                        id: user.id,
                        name: user.name,
                        profileImageUrl: user.profileImageUrl
                    )
                }
                return users
            }
            .asSingle()
    }

    func updateGroup(id: Int64, name: String, description: String) -> Single<Group> {
        let geoPoint = TestData.camphorGeoPoint()
        let inlineObject = InlineObject(
            name: name,
            description: description,
            location: Location(lat: geoPoint.latitude, lng: geoPoint.longitude)
        )
        print(name)
        return CommunityAPI.updateCommunity(id: id, inlineObject: inlineObject)
            .map { community in
                return Group(
                    id: community.id,
                    name: community.name,
                    description: community.description,
                    memberCount: community.numUser,
                    restaurantCount: community.numRestaurant,
                    members: [],
                    isPublic: true,
                    imageUrls: community.imageUrls
                )
            }
            .asSingle()
    }
}

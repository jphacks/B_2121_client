//
//  GroupService.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/28.
//

import RxSwift
import OpenAPIClient

protocol GroupServiceType {
    func createGroup(group: Group) -> Single<Group>
    func searchGroup(keyword: String, location: Location?) -> Single<[GroupSummary]>
    func getGroup(id: String) -> Single<Group>
    func getUsers(groupId: String) -> Single<[User]>
}

final class GroupService: BaseService, GroupServiceType {
    func createGroup(group: Group) -> Single<Group> {
        return .just(TestData.group())
    }

    func searchGroup(keyword: String, location: Location?) -> Single<[GroupSummary]> {
        // TODO: get restaurantCount
        // TODO: get memberCount
        // TODO: get imageUrls
        return CommunityAPI.searchCommunities(keyword: keyword)
            .map { (response: SearchCommunityResponse) in
                guard let communities = response.communities else { return [] }
                let groups = communities.map { community in
                    return GroupSummary(
                        groupId: community.id,
                        groupName: community.name,
                        groupDescription: community.description ?? "",
                        restaurantCount: 0,
                        memberCount: 0,
                        imageUrls: []
                    )
                }
                return groups
            }
            .asSingle()
    }

    func getGroup(id: String) -> Single<Group> {
        return .just(TestData.group())
    }

    func getUsers(groupId: String) -> Single<[User]> {
        return .just(TestData.users(count: 8))
    }
}

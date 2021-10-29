//
//  BookmarkService.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/28.
//

import RxSwift
import OpenAPIClient

protocol BookmarkServiceType {
    // MARK: - Event
    var event: PublishSubject<BookmarkEvent> { get }

    func getBookmarkedGroups(userId: Int64) -> Single<[GroupSummary]>
    func createBookmark(userId: Int64, groupId: Int64) -> Single<Bool>
    func removeBookmark(userId: Int64, groupId: Int64) -> Single<Bool>
}

final class BookmarkService: BaseService, BookmarkServiceType {
    // MARK: - Event
    let event: PublishSubject<BookmarkEvent> = PublishSubject<BookmarkEvent>()

    func getBookmarkedGroups(userId: Int64) -> Single<[GroupSummary]> {
        // TODO: get restaurantCount
        // TODO: get memberCount
        // TODO: get imageUrls
        return BookmarkAPI.userIdBookmarkGet(id: userId)
            .map { (response: ListUserBookmarkResponse) in
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

    func createBookmark(userId: Int64, groupId: Int64) -> Single<Bool> {
        let inlineObject = InlineObject(communityId: groupId)
        return BookmarkAPI.userIdBookmarkPost(id: userId, inlineObject: inlineObject)
            .map { true }
            .asSingle()
    }

    func removeBookmark(userId: Int64, groupId: Int64) -> Single<Bool> {
        return BookmarkAPI.userIdBookmarkCommunityIdDelete(id: userId, communityId: groupId)
            .map { false }
            .asSingle()
    }
}

//
//  BookmarkService.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/28.
//

import RxSwift

protocol BookmarkServiceType {
    func getBookmarkedGroups(userId: Int64) -> Single<[GroupSummary]>
    func createBookmark(userId: String, groupId: String) -> Single<Void>
    func removeBookmark(userId: String, groupId: String) -> Single<Void>
}

final class BookmarkService: BaseService, BookmarkServiceType {
    func getBookmarkedGroups(userId: Int64) -> Single<[GroupSummary]> {
        return .just(TestData.groupSummaries(count: 9))
    }

    func createBookmark(userId: String, groupId: String) -> Single<Void> {
        return .just(())
    }

    func removeBookmark(userId: String, groupId: String) -> Single<Void> {
        return .just(())
    }
}

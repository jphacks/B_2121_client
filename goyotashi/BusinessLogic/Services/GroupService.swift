//
//  GroupService.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/28.
//

import RxSwift

protocol GroupServiceType {
    func createGroup(group: Group) -> Single<Void>
    func searchGroup(keyword: String, location: Location?) -> Single<[HomeGroup]>
}

final class GroupService: BaseService, GroupServiceType {
    func createGroup(group: Group) -> Single<Void> {
        return .just(())
    }

    func searchGroup(keyword: String, location: Location?) -> Single<[HomeGroup]> {
        return .just(TestData.homeGroups(count: 9))
    }
}

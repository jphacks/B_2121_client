//
//  StoreService.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/29.
//

protocol StoreServiceType {
    var authStore: AuthStoreType { get set }
}

final class StoreService: StoreServiceType {
    var authStore: AuthStoreType = AuthStore()
}

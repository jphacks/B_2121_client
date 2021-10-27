//
//  BaseService.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/28.
//

class BaseService {
    unowned let provider: ServiceProviderType

    init(provider: ServiceProviderType) {
        self.provider = provider
    }
}

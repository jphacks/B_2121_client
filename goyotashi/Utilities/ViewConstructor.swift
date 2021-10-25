//
//  ViewConstructor.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/25.
//

protocol ViewConstructor: AnyObject {
    func setupViews()
    func setupViewConstraints()
}

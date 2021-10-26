//
//  RestaurantInformationView.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/26.
//

import UIKit

final class RestaurantInformationView: UIView, ViewConstructor {
    struct Const {
    }

    // MARK: - Views

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: .zero)

        setupViews()
        setupViewConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Methods
    func setupViews() {
    }

    func setupViewConstraints() {
    }
}

//
//  RestaurantHeaderView.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/26.
//

import UIKit
import ReactorKit

final class RestaurantHeaderView: UIView, View, ViewConstructor {
    struct Const {
        static let aspectRatio: CGFloat = 1.42
        static let imageWidth: CGFloat = DeviceSize.screenWidth
        static let imageHeight: CGFloat = imageWidth / aspectRatio
    }

    // MARK: - Variables
    var disposeBag = DisposeBag()

    // MARK: - Views
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.image = R.image.dish()
    }

    private let restaurantNameLabel = UILabel().then {
        $0.apply(fontStyle: .medium, size: 20, color: Color.gray01)
    }

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
        addSubview(imageView)
        addSubview(restaurantNameLabel)
    }

    func setupViewConstraints() {
        snp.makeConstraints {
            $0.height.equalTo(Const.imageHeight)
        }
        imageView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.width.equalTo(Const.imageWidth)
            $0.height.equalTo(Const.imageHeight)
        }
        restaurantNameLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(16)
            $0.left.equalToSuperview().inset(16)
        }
    }

    // MARK: - Bind Method
    func bind(reactor: RestaurantReactor) {
        // Action

        // State
    }
}

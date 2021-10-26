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
        $0.text = "和洋キッチン松之助"
    }

    private let restaurantDescriptionLabel = UILabel().then {
        $0.apply(fontStyle: .regular, size: 13, color: Color.gray03)
        $0.numberOfLines = 0
        $0.text = "定食・食堂・ハンバーグ・洋食"
    }

    private let addRestaurantButton = AddRestaurantButton()

    private let restaurantInformationView = RestaurantInformationView()

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
        addSubview(restaurantDescriptionLabel)
        addSubview(addRestaurantButton)
        addSubview(restaurantInformationView)
    }

    func setupViewConstraints() {
        imageView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.width.equalTo(Const.imageWidth)
            $0.height.equalTo(Const.imageHeight)
        }
        restaurantNameLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(16)
            $0.left.equalToSuperview().inset(16)
        }
        restaurantDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(restaurantNameLabel.snp.bottom).offset(8)
            $0.left.equalToSuperview().inset(16)
            $0.right.equalTo(addRestaurantButton.snp.left).offset(-16)
        }
        addRestaurantButton.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(16)
            $0.right.equalToSuperview().inset(16)
        }
        restaurantInformationView.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(restaurantDescriptionLabel.snp.bottom).offset(32)
            $0.top.greaterThanOrEqualTo(addRestaurantButton.snp.bottom).offset(32)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }

    // MARK: - Bind Method
    func bind(reactor: RestaurantReactor) {
        // Action

        // State
    }
}

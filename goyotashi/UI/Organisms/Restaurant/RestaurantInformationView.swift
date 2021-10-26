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
    private let titleLabel = UILabel().then {
        $0.apply(fontStyle: .medium, size: 18, color: Color.gray01)
        $0.text = "お店情報"
    }

    private let row = RestaurantInformationRow()

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
        addSubview(titleLabel)
        addSubview(row)
    }

    func setupViewConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().inset(16)
        }
        row.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}

fileprivate final class RestaurantInformationRow: UIView, ViewConstructor {

    enum InformationType {
        case restaurantName
        case address
        case phoneNumber
        case openingHours

        var title: String {
            switch self {
            case .restaurantName:
                return "店名"
            case .address:
                return "住所"
            case .phoneNumber:
                return "電話"
            case .openingHours:
                return "営業時間"
            }
        }
    }

    // MARK: - Views
    private let titleLabel = UILabel().then {
        $0.apply(fontStyle: .bold, size: 14, color: Color.gray01)
        $0.text = "店名"
    }

    private let descriptionLabel = UILabel().then {
        $0.apply(fontStyle: .regular, size: 14, color: Color.gray01)
        $0.numberOfLines = 0
        $0.text = "和洋キッチン松之助"
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
        addSubview(titleLabel)
        addSubview(descriptionLabel)
    }

    func setupViewConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().inset(16)
        }
        descriptionLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().inset(96)
            $0.right.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }
}

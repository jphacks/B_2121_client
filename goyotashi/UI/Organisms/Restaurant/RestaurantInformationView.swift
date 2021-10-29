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

    private let informationRowStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 16
    }

    private let restaurantNameRow = RestaurantInformationRow(informationType: .restaurantName)
    private let addressRow = RestaurantInformationRow(informationType: .address)
    private let phoneNumberRow = RestaurantInformationRow(informationType: .phoneNumber)
    private let openingHoursRow = RestaurantInformationRow(informationType: .openingHours)

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
        addSubview(informationRowStackView)
        informationRowStackView.addArrangedSubview(restaurantNameRow)
        //        informationRowStackView.addArrangedSubview(addressRow)
        //        informationRowStackView.addArrangedSubview(phoneNumberRow)
        //        informationRowStackView.addArrangedSubview(openingHoursRow)
    }

    func setupViewConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().inset(16)
        }
        informationRowStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }

    // MARK: - Configure Methods
    func configure(restaurantName: String, address: String, phoneNumber: String, openingHours: String) {
        restaurantNameRow.configure(description: restaurantName)
        addressRow.configure(description: address)
        phoneNumberRow.configure(description: phoneNumber)
        openingHoursRow.configure(description: openingHours)
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
    }

    private let descriptionLabel = UILabel().then {
        $0.apply(fontStyle: .regular, size: 14, color: Color.gray01)
        $0.numberOfLines = 0
    }

    // MARK: - Initializers
    init(informationType: InformationType) {
        super.init(frame: .zero)

        setupViews()
        setupViewConstraints()
        configure(informationType: informationType)
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
            $0.bottom.lessThanOrEqualToSuperview()
        }
        descriptionLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().inset(96)
            $0.right.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }

    // MARK: - Configure Methods
    private func configure(informationType: InformationType) {
        titleLabel.text = informationType.title
    }

    func configure(description: String) {
        descriptionLabel.text = description
    }
}

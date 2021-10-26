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
    // MARK: - Views
    private let titleLabel = UILabel().then {
        $0.apply(fontStyle: .bold, size: 14, color: Color.gray01)
        $0.text = "店名"
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
    }

    func setupViewConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }
}

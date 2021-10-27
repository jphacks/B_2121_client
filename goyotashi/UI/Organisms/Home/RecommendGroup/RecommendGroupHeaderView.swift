//
//  RecommendGroupHeaderView.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/27.
//

import UIKit

final class RecommendGroupHeaderView: UIView, ViewConstructor {
    struct Const {
        static let height: CGFloat = 148
    }

    // MARK: - Views
    private let titleLabel = UILabel().then {
        $0.apply(fontStyle: .bold, size: 24, color: Color.gray01)
        $0.text = "グループ"
    }

    private let mapIconBackgroundView = UIView().then {
        $0.backgroundColor = Color.gray06
        $0.layer.cornerRadius = 24
    }

    private let mapIconView = UIImageView().then {
        $0.image = R.image.location()
        $0.contentMode = .scaleAspectFit
    }

    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 4
    }

    private let searchAroundHereLabel = UILabel().then {
        $0.apply(fontStyle: .medium, size: 16, color: Color.gray02)
        $0.text = "近くを検索する"
    }

    private let precautionaryStatementLabel = UILabel().then {
        $0.apply(fontStyle: .medium, size: 12, color: Color.gray03)
        $0.text = "位置情報を使います"
    }

    private let searchAroundHereSwitch = UISwitch()

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
        addSubview(mapIconBackgroundView)
        mapIconBackgroundView.addSubview(mapIconView)
        addSubview(stackView)
        stackView.addArrangedSubview(searchAroundHereLabel)
        stackView.addArrangedSubview(precautionaryStatementLabel)
        addSubview(searchAroundHereSwitch)
    }

    func setupViewConstraints() {
        snp.makeConstraints {
            $0.height.equalTo(Const.height)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.left.equalToSuperview().inset(16)
        }
        mapIconBackgroundView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
            $0.left.equalToSuperview().inset(16)
            $0.size.equalTo(64)
        }
        mapIconView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(24)
        }
        stackView.snp.makeConstraints {
            $0.centerY.equalTo(mapIconBackgroundView)
            $0.left.equalTo(mapIconBackgroundView.snp.right).offset(8)
        }
        searchAroundHereSwitch.snp.makeConstraints {
            $0.centerY.equalTo(mapIconBackgroundView)
            $0.right.equalToSuperview().inset(16)
        }
    }
}

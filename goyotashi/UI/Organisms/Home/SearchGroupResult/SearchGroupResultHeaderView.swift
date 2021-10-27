//
//  SearchGroupResultHeaderView.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/27.
//

import UIKit

final class SearchGroupResultHeaderView: UIView, ViewConstructor {
    struct Const {
        static let height: CGFloat = 48
    }

    // MARK: - Views
    private let titleLabel = UILabel().then {
        $0.apply(fontStyle: .medium, size: 15, color: Color.gray02)
        $0.text = "検索結果"
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
        snp.makeConstraints {
            $0.width.equalTo(DeviceSize.screenWidth)
            $0.height.equalTo(Const.height)
        }
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(16)
        }
    }
}

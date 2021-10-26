//
//  GroupHeaderView.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/26.
//

import UIKit

final class GroupHeaderView: UIView, ViewConstructor {
    struct Const {
        static let height: CGFloat = 400
    }

    // MARK: - Views
    private let groupNameLabel = UILabel().then {
        $0.apply(fontStyle: .bold, size: 24, color: Color.gray01)
        $0.text = "グループ"
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
        addSubview(groupNameLabel)
    }

    func setupViewConstraints() {
        groupNameLabel.snp.makeConstraints {
            $0.top.left.equalToSuperview().inset(16)
        }
    }
}

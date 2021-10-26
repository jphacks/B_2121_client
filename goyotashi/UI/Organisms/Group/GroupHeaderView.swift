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

    private let groupMemberButton = GroupMemberButton().then {
        let urlStrings: [String] = (0 ..< 2).map { _ in
            "https://avatars.githubusercontent.com/u/38304075?v=4"
        }
        $0.configure(
            imageUrlStrings: urlStrings,
            memberCount: 5
        )
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
        addSubview(groupMemberButton)
    }

    func setupViewConstraints() {
        snp.makeConstraints {
            $0.height.equalTo(Const.height)
        }
        groupNameLabel.snp.makeConstraints {
            $0.top.left.equalToSuperview().inset(16)
        }
        groupMemberButton.snp.makeConstraints {
            $0.top.equalTo(groupNameLabel.snp.bottom).offset(24)
            $0.left.equalToSuperview().inset(16)
        }
    }
}

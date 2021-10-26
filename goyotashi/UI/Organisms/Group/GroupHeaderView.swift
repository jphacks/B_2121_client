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

    private let descriptionLabel = UILabel().then {
        $0.apply(fontStyle: .medium, size: 13, color: Color.gray02)
        $0.numberOfLines = 0
        $0.text = "CAMPHOR-カンファーは京都のIT系学生コミュニティです。エンジニアリング・デザイン・プロダクト開発などへの関心を共通点とする、様々なバックグラウンドを持つ学生が集まっています。"
    }

    private let actionButtonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
    }

    private let organizeButton = GroupActionButton(actionType: .organize)
    private let editButton = GroupActionButton(actionType: .edit)
    private let addMemberButton = GroupActionButton(actionType: .addMember)
    private let bookmarkButton = GroupActionButton(actionType: .bookmark)

    private let restaurantCountLabel = UILabel().then {
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
        addSubview(groupNameLabel)
        addSubview(groupMemberButton)
        addSubview(descriptionLabel)
        addSubview(actionButtonStackView)
        actionButtonStackView.addArrangedSubview(organizeButton)
        actionButtonStackView.addArrangedSubview(editButton)
        actionButtonStackView.addArrangedSubview(addMemberButton)
        actionButtonStackView.addArrangedSubview(bookmarkButton)
        addSubview(restaurantCountLabel)
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
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(groupMemberButton.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(16)
        }
        actionButtonStackView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(32)
            $0.left.equalToSuperview().inset(16)
            $0.right.lessThanOrEqualToSuperview().inset(16)
        }
        restaurantCountLabel.snp.makeConstraints {
            $0.top.equalTo(actionButtonStackView.snp.bottom).offset(48)
            $0.left.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
}

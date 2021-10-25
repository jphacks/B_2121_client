//
//  ProfileHeaderView.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/26.
//

import UIKit

final class ProfileHeaderView: UIView, ViewConstructor {
    struct Const {
        static let profileImageSize: CGFloat = 84
        static let height: CGFloat = 148
    }

    // MARK: - Views
    private let profileImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = Const.profileImageSize / 2
        $0.layer.masksToBounds = true
    }

    private let userNameLabel = UILabel().then {
        $0.apply(fontStyle: .bold, size: 24, color: Color.gray01)
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
        addSubview(profileImageView)
        addSubview(userNameLabel)
    }

    func setupViewConstraints() {
        profileImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.left.equalToSuperview().inset(16)
            $0.size.equalTo(Const.profileImageSize)
        }
        userNameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(24)
            $0.left.right.equalToSuperview().inset(16)
        }
    }
}

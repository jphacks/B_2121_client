//
//  ProfileHeaderView.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/26.
//

import UIKit
import ReactorKit

final class ProfileHeaderView: UIView, View, ViewConstructor {
    struct Const {
        static let profileImageSize: CGFloat = 84
        static let height: CGFloat = 264
    }

    // MARK: - Variables
    var disposeBag = DisposeBag()

    // MARK: - Views
    private let profileImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = Const.profileImageSize / 2
        $0.layer.masksToBounds = true
    }

    private let userNameLabel = UILabel().then {
        $0.apply(fontStyle: .bold, size: 24, color: Color.gray01)
    }

    private let editProfileButton = RoundBorderButton().then {
        $0.set(title: "プロフィールを編集")
    }

    private let moreButton = RoundBorderDotsButton()

    let plusButton = PlusButton()

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
        addSubview(editProfileButton)
        addSubview(moreButton)
        addSubview(plusButton)
    }

    func setupViewConstraints() {
        snp.makeConstraints {
            $0.height.equalTo(Const.height)
        }
        profileImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.left.equalToSuperview().inset(16)
            $0.size.equalTo(Const.profileImageSize)
        }
        userNameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(24)
            $0.left.right.equalToSuperview().inset(16)
        }
        editProfileButton.snp.makeConstraints {
            $0.top.equalTo(userNameLabel.snp.bottom).offset(16)
            $0.left.equalToSuperview().inset(16)
        }
        moreButton.snp.makeConstraints {
            $0.centerY.equalTo(editProfileButton)
            $0.left.equalTo(editProfileButton.snp.right).offset(16)
        }
        plusButton.snp.makeConstraints {
            $0.centerY.equalTo(editProfileButton)
            $0.right.equalToSuperview().inset(16)
        }
    }

    // MARK: - Bind Method
    func bind(reactor: ProfileReactor) {
        // Action

        // State
        reactor.state.map { $0.user?.profileImageUrl }
            .distinctUntilChanged()
            .filterNil()
            .bind { [weak self] urlString in
                self?.profileImageView.kf.setImage(with: URL(string: urlString), placeholder: R.image.dish())
            }
            .disposed(by: disposeBag)

        reactor.state.map { $0.user?.userName }
            .distinctUntilChanged()
            .bind(to: userNameLabel.rx.text)
            .disposed(by: disposeBag)
    }
}

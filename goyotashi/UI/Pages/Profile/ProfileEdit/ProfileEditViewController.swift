//
//  ProfileEditViewController.swift
//  goyotashi
//
//  Created by 山河絵利奈 on 2021/10/29.
//

import UIKit
import ReactorKit
import SegementSlide

final class ProfileEditViewController: UIViewController, View, ViewConstructor {
    struct Const {
        static let profileImageSize: CGFloat = 84
    }

    // MARK: - Variables
    var disposeBag = DisposeBag()

    // MARK: - Views
    private let profileImageLabel = UILabel().then {
        $0.apply(fontStyle: .regular, size: 15, color: Color.gray01)
        $0.text = "プロフィール画像"
    }

    private let userNameLabel = UILabel().then {
        $0.apply(fontStyle: .regular, size: 15, color: Color.gray01)
        $0.text = "ニックネーム"
    }

    private let profileImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = Const.profileImageSize / 2
        $0.layer.masksToBounds = true
    }

    private let userNameTextField = UITextField().then {
        $0.font = UIFont(name: FontStyle.regular.rawValue, size: 18)
    }

    // MARK: - Lify Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupViewConstraints()
    }

    // MARK: - Setup Methods
    func setupViews() {
        view.addSubview(profileImageLabel)
        view.addSubview(profileImageView)
        view.addSubview(userNameLabel)
        view.addSubview(userNameTextField)

        title = "プロフィール編集"
    }

    func setupViewConstraints() {
        profileImageLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(32)
            $0.left.right.equalToSuperview().inset(16)
        }
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(profileImageLabel.snp.bottom).offset(24)
            $0.left.equalToSuperview().inset(16)
            $0.size.equalTo(Const.profileImageSize)
        }
        userNameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(24)
            $0.left.right.equalToSuperview().inset(16)
        }
        userNameTextField.snp.makeConstraints {
            $0.top.equalTo(userNameLabel.snp.bottom).offset(24)
            $0.left.right.equalToSuperview().inset(16)
        }
    }

    // MARK: - Bind Method
    func bind(reactor: ProfileEditReactor) {
        // Action
        reactor.action.onNext(.refresh)

        // State
        reactor.state.map { $0.user?.profileImageUrl }
            .distinctUntilChanged()
            .filterNil()
            .bind { [weak self] urlString in
                self?.profileImageView.kf.setImage(with: URL(string: urlString), placeholder: R.image.dish())
            }
            .disposed(by: disposeBag)

        reactor.state.map { $0.user?.name }
            .distinctUntilChanged()
            .bind(to: userNameTextField.rx.text)
            .disposed(by: disposeBag)
    }
}

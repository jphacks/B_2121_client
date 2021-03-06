//
//  ProfileEditViewController.swift
//  goyotashi
//
//  Created by 山河絵利奈 on 2021/10/29.
//

import UIKit
import ReactorKit
// import SegementSlide

final class ProfileEditViewController: UIViewController, View, ViewConstructor {
    struct Const {
        static let profileImageSize: CGFloat = 84
    }

    // MARK: - Variables
    var disposeBag = DisposeBag()

    // MARK: - Views
    private let closeButton = UIButton().then {
        $0.setImage(R.image.close(), for: .normal)
    }

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

    private let doneButton = UIBarButtonItem(title: "完了", style: .done, target: nil, action: nil).then {
        $0.tintColor = Color.gray01
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
        view.backgroundColor = Color.white
        title = "プロフィール編集"

        navigationItem.rightBarButtonItem = doneButton
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: closeButton)
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

        doneButton.rx.tap
            .map { Reactor.Action.update }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        userNameTextField.rx.text
            .distinctUntilChanged()
            .map { Reactor.Action.updateName($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        // State
        reactor.state.map { $0.profileImageUrl }
            .distinctUntilChanged()
            .filterNil()
            .bind { [weak self] urlString in
                self?.profileImageView.kf.setImage(with: URL(string: urlString), placeholder: R.image.dish())
            }
            .disposed(by: disposeBag)

        reactor.state.map { $0.name }
            .distinctUntilChanged()
            .bind(to: userNameTextField.rx.text)
            .disposed(by: disposeBag)

        reactor.state.map { $0.apiStatus }
            .distinctUntilChanged()
            .bind { [weak self] apiStatus in
                self?.doneButton.isEnabled = apiStatus == .pending
                if apiStatus == .succeeded {
                    self?.dismiss(animated: false, completion: nil)
                }
                if apiStatus == .failed {
                    logger.error("failed to create a group")
                }
            }
            .disposed(by: disposeBag)

        closeButton.rx.tap
            .bind { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
    }
}

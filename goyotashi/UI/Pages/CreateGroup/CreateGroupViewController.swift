//
//  CreateGroupViewController.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/26.
//

import UIKit
import ReactorKit

final class CreateGroupViewController: UIViewController, View, ViewConstructor {

    // MARK: - Variables
    var disposeBag = DisposeBag()

    // MARK: - Views
    private let closeButton = UIButton().then {
        $0.setImage(R.image.close(), for: .normal)
    }

    private let createButton = UIBarButtonItem(title: "作成", style: .done, target: nil, action: nil).then {
        $0.tintColor = Color.gray01
    }

    private let scrollView = UIScrollView().then {
        $0.alwaysBounceVertical = true
    }

    private let groupNameLabel = UILabel().then {
        $0.apply(fontStyle: .regular, size: 15, color: Color.gray01)
        $0.text = "グループ名"
    }

    private let groupNameTextField = UITextField().then {
        $0.placeholder = "グループ名を入力"
        $0.font = UIFont(name: FontStyle.bold.rawValue, size: 18)
        $0.adjustsFontSizeToFitWidth = true
    }

    private let groupMemberLabel = UILabel().then {
        $0.apply(fontStyle: .regular, size: 15, color: Color.gray01)
        $0.text = "グループのメンバー"
    }

    private let countableGroupMemberButton = CountableGroupMemberButton()

    private let addMemberButton = AddMemberButton()

    private let groupDescriptionLabel = UILabel().then {
        $0.apply(fontStyle: .regular, size: 15, color: Color.gray01)
        $0.text = "グループの説明"
    }

    private let groupDescriptionTextView = PlaceholderTextView().then {
        $0.font = UIFont(name: FontStyle.medium.rawValue, size: 14)
        $0.textColor = Color.gray01
        $0.placeholder = "グループの説明を入力"
    }

    private let privacyTitleLabel = UILabel().then {
        $0.apply(fontStyle: .regular, size: 15, color: Color.gray01)
        $0.text = "公開／非公開"
    }

    private let privacyStateLabel = UILabel().then {
        $0.apply(fontStyle: .bold, size: 19, color: Color.gray01)
    }

    private let privacySwitch = UISwitch()

    private let privacyDescriptionLabel = UILabel().then {
        $0.apply(fontStyle: .regular, size: 15, color: Color.gray04)
        $0.numberOfLines = 0
    }

    private let apiStatusView = APIStatusView()

    // MARK: - Lify Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupViewConstraints()
    }

    // MARK: - Setup Methods
    func setupViews() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: closeButton)
        navigationItem.rightBarButtonItem = createButton

        view.backgroundColor = Color.white
        title = "新しいグループを作成"

        view.addSubview(scrollView)
        scrollView.addSubview(groupNameLabel)
        scrollView.addSubview(groupNameTextField)
        scrollView.addSubview(groupMemberLabel)
        scrollView.addSubview(countableGroupMemberButton)
        scrollView.addSubview(addMemberButton)
        scrollView.addSubview(groupDescriptionLabel)
        scrollView.addSubview(groupDescriptionTextView)
        scrollView.addSubview(privacyTitleLabel)
        scrollView.addSubview(privacyStateLabel)
        scrollView.addSubview(privacySwitch)
        scrollView.addSubview(privacyDescriptionLabel)
        view.addSubview(apiStatusView)
    }

    func setupViewConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        groupNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.left.equalToSuperview().inset(16)
        }
        groupNameTextField.snp.makeConstraints {
            $0.top.equalTo(groupNameLabel.snp.bottom).offset(8)
            $0.left.right.equalTo(view).inset(16)
        }
        groupMemberLabel.snp.makeConstraints {
            $0.top.equalTo(groupNameTextField.snp.bottom).offset(40)
            $0.left.equalToSuperview().inset(16)
        }
        countableGroupMemberButton.snp.makeConstraints {
            $0.top.equalTo(groupMemberLabel.snp.bottom).offset(8)
            $0.left.equalToSuperview().inset(16)
        }
        addMemberButton.snp.makeConstraints {
            $0.centerY.equalTo(countableGroupMemberButton)
            $0.right.equalTo(view).inset(16)
        }
        groupDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(addMemberButton.snp.bottom).offset(40)
            $0.left.equalToSuperview().inset(16)
        }
        groupDescriptionTextView.snp.makeConstraints {
            $0.top.equalTo(groupDescriptionLabel.snp.bottom).offset(8)
            $0.left.right.equalTo(view).inset(12)
            $0.height.equalTo(72)
        }
        privacyTitleLabel.snp.makeConstraints {
            $0.top.equalTo(groupDescriptionTextView.snp.bottom).offset(40)
            $0.left.equalToSuperview().inset(16)
        }
        privacyStateLabel.snp.makeConstraints {
            $0.top.equalTo(privacyTitleLabel.snp.bottom).offset(8)
            $0.left.equalToSuperview().inset(16)
        }
        privacySwitch.snp.makeConstraints {
            $0.centerY.equalTo(privacyStateLabel)
            $0.right.equalTo(view).inset(16)
        }
        privacyDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(privacyStateLabel.snp.bottom).offset(8)
            $0.left.equalToSuperview().inset(16)
            $0.right.equalTo(privacySwitch.snp.left).offset(-20)
        }
        apiStatusView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: - Bind Method
    func bind(reactor: CreateGroupReactor) {
        // Action
        createButton.rx.tap
            .map { Reactor.Action.create }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        closeButton.rx.tap
            .bind { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            }
            .disposed(by: disposeBag)

        groupNameTextField.rx.text
            .distinctUntilChanged()
            .map { Reactor.Action.updateGroupName($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        groupDescriptionTextView.rx.text
            .distinctUntilChanged()
            .map { Reactor.Action.updateGroupDescription($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        privacySwitch.rx.isOn
            .distinctUntilChanged()
            .map { Reactor.Action.updateIsOnPrivacySwitch($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        // State
        reactor.state.map { $0.members }
            .distinctUntilChanged()
            .bind(to: countableGroupMemberButton.rx.members)
            .disposed(by: disposeBag)

        reactor.state.map { $0.isPublic }
            .distinctUntilChanged()
            .bind(to: privacySwitch.rx.isOn)
            .disposed(by: disposeBag)

        reactor.state.map { $0.isPublic }
            .distinctUntilChanged()
            .bind { [weak self] isPublic in
                self?.privacyStateLabel.text = isPublic ? "公開する" : "非公開にする"
                self?.privacyDescriptionLabel.text = isPublic ? "すべてのユーザがグループの内容を見ることができます。" : "グループに参加しているメンバーだけがグループの内容を見ることができます。"
            }
            .disposed(by: disposeBag)

        reactor.state.map { $0.apiStatus }
            .distinctUntilChanged()
            .bind { [weak self] apiStatus in
                self?.createButton.isEnabled = apiStatus == .pending
                if apiStatus == .succeeded {
                    self?.dismiss(animated: true, completion: nil)
                }
                if apiStatus == .failed {
                    logger.error("failed to create a group")
                }
            }
            .disposed(by: disposeBag)

        reactor.state.map { $0.apiStatus }
            .distinctUntilChanged()
            .bind(to: apiStatusView.rx.apiStatus)
            .disposed(by: disposeBag)
    }
}

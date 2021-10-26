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

    private let privacyTitleLabel = UILabel().then {
        $0.apply(fontStyle: .regular, size: 15, color: Color.gray01)
        $0.text = "公開／非公開"
    }

    private let privacyStateLabel = UILabel().then {
        $0.apply(fontStyle: .bold, size: 19, color: Color.gray01)
        $0.text = "公開する"
    }

    private let privacySwitch = UISwitch()

    private let privacyDescriptionLabel = UILabel().then {
        $0.apply(fontStyle: .regular, size: 15, color: Color.gray04)
        $0.numberOfLines = 0
        $0.text = "すべてのユーザがグループの内容を見ることができます。"
    }

    // MARK: - Lify Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupViewConstraints()
    }

    // MARK: - Setup Methods
    func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(groupNameLabel)
        scrollView.addSubview(groupNameTextField)
        scrollView.addSubview(groupMemberLabel)
        scrollView.addSubview(countableGroupMemberButton)
        scrollView.addSubview(privacyTitleLabel)
        scrollView.addSubview(privacyStateLabel)
        scrollView.addSubview(privacySwitch)
        scrollView.addSubview(privacyDescriptionLabel)
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
        privacyTitleLabel.snp.makeConstraints {
            $0.top.equalTo(countableGroupMemberButton.snp.bottom).offset(40)
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
    }

    // MARK: - Bind Method
    func bind(reactor: CreateGroupReactor) {
        // Action
        groupNameTextField.rx.text
            .distinctUntilChanged()
            .map { Reactor.Action.updateGroupName($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        privacySwitch.rx.isOn
            .distinctUntilChanged()
            .bind { isOn in
                print("isOn: \(isOn)")
            }
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
    }
}

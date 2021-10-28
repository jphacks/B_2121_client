//
//  GroupHeaderView.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/26.
//

import UIKit
import ReactorKit

final class GroupHeaderView: UIView, View, ViewConstructor {
    struct Const {
        static let plusButtonSize: CGFloat = 32
    }

    // MARK: - Variables
    var disposeBag = DisposeBag()

    // MARK: - Views
    private let groupNameLabel = UILabel().then {
        $0.apply(fontStyle: .bold, size: 24, color: Color.gray01)
    }

    private let groupMemberButton = GroupMemberButton()

    private let descriptionLabel = UILabel().then {
        $0.apply(fontStyle: .medium, size: 13, color: Color.gray02)
        $0.numberOfLines = 0
    }

    private let actionButtonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
    }

    let organizeButton = GroupActionButton(actionType: .organize)
    let editButton = GroupActionButton(actionType: .edit)
    let addMemberButton = GroupActionButton(actionType: .addMember)
    private let bookmarkButton = GroupActionButton(actionType: .bookmark)

    private let restaurantCountLabel = UILabel().then {
        $0.apply(fontStyle: .medium, size: 20, color: Color.gray01)
    }

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
        addSubview(groupNameLabel)
        addSubview(groupMemberButton)
        addSubview(descriptionLabel)
        addSubview(actionButtonStackView)
        actionButtonStackView.addArrangedSubview(organizeButton)
        actionButtonStackView.addArrangedSubview(editButton)
        actionButtonStackView.addArrangedSubview(addMemberButton)
        actionButtonStackView.addArrangedSubview(bookmarkButton)
        addSubview(restaurantCountLabel)
        addSubview(plusButton)
    }

    func setupViewConstraints() {
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
        plusButton.snp.makeConstraints {
            $0.centerY.equalTo(restaurantCountLabel)
            $0.right.equalToSuperview().inset(16)
            $0.size.equalTo(Const.plusButtonSize)
        }
    }

    // MARK: - Bind Method
    func bind(reactor: GroupReactor) {
        // Action

        // State
        reactor.state.map { $0.group?.name }
            .distinctUntilChanged()
            .bind(to: groupNameLabel.rx.text)
            .disposed(by: disposeBag)

        reactor.state.map { $0.group }
            .filterNil()
            .bind { [weak self] group in
                let imageUrlStrings = group.members.map { $0.profileImageUrl }
                self?.groupMemberButton.configure(imageUrlStrings: imageUrlStrings, memberCount: group.memberCount)
            }
            .disposed(by: disposeBag)

        reactor.state.map { $0.group?.description }
            .distinctUntilChanged()
            .bind(to: descriptionLabel.rx.text)
            .disposed(by: disposeBag)

        reactor.state.map { $0.isMember }
            .distinctUntilChanged()
            .bind { [weak self] isMember in
                self?.organizeButton.isHidden = !isMember
                self?.editButton.isHidden = !isMember
                self?.addMemberButton.isHidden = !isMember
                self?.bookmarkButton.isHidden = isMember
                self?.plusButton.isHidden = !isMember
            }
            .disposed(by: disposeBag)

        reactor.state.map { $0.group?.restaurantCount }
            .distinctUntilChanged()
            .filterNil()
            .map { "\($0)件のお店"}
            .bind(to: restaurantCountLabel.rx.text)
            .disposed(by: disposeBag)
    }
}

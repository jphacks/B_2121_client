//
//  HomeGroupCell.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/25.
//

import UIKit
import ReactorKit

final class HomeGroupCell: UICollectionViewCell, View, ViewConstructor {

    struct Const {
        static let cellWidth: CGFloat = DeviceSize.screenWidth - 32
        static let cellHeight: CGFloat = 320
        static let itemSize: CGSize = CGSize(width: cellWidth, height: cellHeight)
    }

    // MARK: - Variables
    var disposeBag = DisposeBag()

    // MARK: - Views
    private let imagesView = UIView().then {
        $0.layer.cornerRadius = 16
        $0.layer.masksToBounds = true
        $0.backgroundColor = Color.gray06
    }

    private let groupNameLabel = UILabel().then {
        $0.apply(fontStyle: .bold, size: 16, color: Color.gray01)
    }

    private let descriptionLabel = UILabel().then {
        $0.apply(fontStyle: .medium, size: 14, color: Color.gray03)
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
        contentView.addSubview(imagesView)
        contentView.addSubview(groupNameLabel)
        contentView.addSubview(descriptionLabel)
    }

    func setupViewConstraints() {
        imagesView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(280)
        }
        groupNameLabel.snp.makeConstraints {
            $0.top.equalTo(imagesView.snp.bottom).offset(8)
            $0.left.equalToSuperview().inset(8)
        }
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(groupNameLabel.snp.bottom).offset(8)
            $0.left.equalToSuperview().inset(8)
        }
    }

    // MARK: - Bind Method
    func bind(reactor: HomeGroupCellReactor) {
        // Action

        // State
        reactor.state.map { $0.homeGroup.groupName }
            .distinctUntilChanged()
            .bind(to: groupNameLabel.rx.text)
            .disposed(by: disposeBag)

        reactor.state.map { $0.description }
            .distinctUntilChanged()
            .bind(to: descriptionLabel.rx.text)
            .disposed(by: disposeBag)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

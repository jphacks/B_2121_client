//
//  MemberCell.swift
//  goyotashi
//
//  Created by 山河絵利奈 on 2021/10/27.
//

import UIKit
import ReactorKit
import Kingfisher

final class MemberCell: UICollectionViewCell, View, ViewConstructor {

    struct Const {
        static let imageViewSize: CGFloat = 44
        static let cellWidth: CGFloat = DeviceSize.screenWidth - 32
        static let cellHeight: CGFloat = imageViewSize + 16
        static let itemSize: CGSize = CGSize(width: cellWidth, height: cellHeight)
    }

    // MARK: - Variables
    var disposeBag = DisposeBag()

    // MARK: - Views
    private let memberIconView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = Const.imageViewSize / 2
        $0.layer.masksToBounds = true
    }

    private let memberNameLabel = UILabel().then {
        $0.apply(fontStyle: .medium, size: 14, color: Color.gray01)
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
        contentView.addSubview(memberIconView)
        contentView.addSubview(memberNameLabel)
    }

    func setupViewConstraints() {
        memberIconView.snp.makeConstraints {
            $0.left.centerY.equalToSuperview()
            $0.height.width.equalTo(Const.imageViewSize)
        }
        memberNameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(memberIconView.snp.right).offset(8)
        }
    }

    // MARK: - Bind Method
    func bind(reactor: MemberCellReactor) {
        // Action

        // State
        reactor.state.map { $0.member.profileImageUrl }
            .distinctUntilChanged()
            .filterNil()
            .bind { [weak self] urlString in
                self?.memberIconView.kf.setImage(with: URL(string: urlString), placeholder: R.image.dish())
            }
            .disposed(by: disposeBag)

        reactor.state.map { $0.member.name }
            .distinctUntilChanged()
            .bind(to: memberNameLabel.rx.text)
            .disposed(by: disposeBag)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

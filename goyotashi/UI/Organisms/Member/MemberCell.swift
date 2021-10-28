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
        static let imageViewWidth: CGFloat = 44
        static let imageViewHeight: CGFloat = 44
        static let cellWidth: CGFloat = DeviceSize.screenWidth - 32
        static let cellHeight: CGFloat = imageViewHeight + 16
        static let itemSize: CGSize = CGSize(width: cellWidth, height: cellHeight)
    }

    // MARK: - Variables
    var disposeBag = DisposeBag()

    // MARK: - Views
    private let memberIconView: MemberIconView = MemberIconView().then {
        $0.isUserInteractionEnabled = false
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
            $0.top.bottom.left.equalToSuperview()
            $0.height.equalTo(Const.imageViewHeight)
            $0.width.equalTo(Const.imageViewWidth)
        }
        memberNameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(48)
        }
    }

    // MARK: - Bind Method
    func bind(reactor: MemberCellReactor) {
        // Action

        // State
        reactor.state.map { $0.member.profileImageUrl }
            .distinctUntilChanged()
            .bind { [weak self] urlString in
                self?.memberIconView.imageView.kf.setImage(with: URL(string: urlString), placeholder: R.image.dish())
            }
            .disposed(by: disposeBag)

        reactor.state.map { $0.member.userName }
            .distinctUntilChanged()
            .bind(to: memberNameLabel.rx.text)
            .disposed(by: disposeBag)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

fileprivate final class MemberIconView: UIView, ViewConstructor {
    struct Const {
        static let size: CGFloat = 46
        static let imageViewSize: CGFloat = 44
    }

    // MARK: - Views

    let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = Const.imageViewSize / 2
        $0.layer.masksToBounds = true
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
        backgroundColor = Color.white
        layer.cornerRadius = Const.size / 2
        layer.masksToBounds = true

        addSubview(imageView)
    }

    func setupViewConstraints() {
        snp.makeConstraints {
            $0.size.equalTo(Const.size)
        }
        imageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(Const.imageViewSize)
        }
    }
}

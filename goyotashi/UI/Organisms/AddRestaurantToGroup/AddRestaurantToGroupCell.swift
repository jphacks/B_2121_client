//
//  AddRestaurantToGroupCell.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/27.
//

import UIKit
import ReactorKit
import Kingfisher

final class AddRestaurantToGroupCell: UICollectionViewCell, View, ViewConstructor {

    struct Const {
        static let imageViewSize: CGFloat = ((DeviceSize.screenWidth - 32 - 8) / 2 - 4) / 2
        static let imagesViewWidth: CGFloat = imageViewSize * 2 + 4
        static let cellWidth: CGFloat = DeviceSize.screenWidth - 32
        static let cellHeight: CGFloat = imageViewSize * 2 + 4
        static let itemSize: CGSize = CGSize(width: cellWidth, height: cellHeight)
    }

    // MARK: - Variables
    var disposeBag = DisposeBag()

    // MARK: - Views
    private let imagesView = UIView().then {
        $0.layer.cornerRadius = 16
        $0.layer.masksToBounds = true
    }

    private let imageViews: [UIImageView] = {
        var imageViews: [UIImageView] = (0 ..< 4).map { _ in
            let imageView = UIImageView().then {
                $0.contentMode = .scaleAspectFill
                $0.clipsToBounds = true
                $0.image = R.image.dish()
            }
            return imageView
        }
        return imageViews
    }()

    private let stackView = UIStackView().then {
        $0.axis = .vertical
    }

    private let groupNameLabel = UILabel().then {
        $0.apply(fontStyle: .bold, size: 18, color: Color.gray01)
        $0.numberOfLines = 0
    }

    private let groupDescriptionLabel = UILabel().then {
        $0.apply(fontStyle: .medium, size: 11, color: Color.gray03)
        $0.numberOfLines = 0
    }

    private let groupSummaryLabel = UILabel().then {
        $0.apply(fontStyle: .medium, size: 12, color: Color.gray02)
        $0.numberOfLines = 0
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
        _ = imageViews.map {
            imagesView.addSubview($0)
        }
        contentView.addSubview(imagesView)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(groupNameLabel)
        stackView.addArrangedSubview(groupDescriptionLabel)
        stackView.setCustomSpacing(8, after: groupDescriptionLabel)
        stackView.addArrangedSubview(groupSummaryLabel)
    }

    func setupViewConstraints() {
        imagesView.snp.makeConstraints {
            $0.top.left.bottom.equalToSuperview()
            $0.width.equalTo(Const.imagesViewWidth)
        }
        imageViews[0].snp.makeConstraints {
            $0.top.left.equalToSuperview()
            $0.size.equalTo(Const.imageViewSize)
        }
        imageViews[1].snp.makeConstraints {
            $0.top.right.equalToSuperview()
            $0.size.equalTo(Const.imageViewSize)
        }
        imageViews[2].snp.makeConstraints {
            $0.left.bottom.equalToSuperview()
            $0.size.equalTo(Const.imageViewSize)
        }
        imageViews[3].snp.makeConstraints {
            $0.right.bottom.equalToSuperview()
            $0.size.equalTo(Const.imageViewSize)
        }
        stackView.snp.makeConstraints {
            $0.top.greaterThanOrEqualToSuperview().inset(8)
            $0.bottom.lessThanOrEqualToSuperview().inset(8)
            $0.centerY.equalToSuperview()
            $0.left.equalTo(imagesView.snp.right).offset(8)
            $0.right.equalToSuperview()
        }
    }

    // MARK: - Bind Method
    func bind(reactor: AddRestaurantToGroupCellReactor) {
        // Action

        // State
        reactor.state.map { $0.groupSummary.imageUrls }
            .distinctUntilChanged()
            .bind { [weak self] imageUrls in
                let max = min(imageUrls.count, 4)
                for index in 0 ..< max {
                    self?.imageViews[index].kf.setImage(with: URL(string: imageUrls[index]), placeholder: R.image.dish())
                }
            }
            .disposed(by: disposeBag)

        reactor.state.map { $0.groupSummary.groupName }
            .distinctUntilChanged()
            .bind(to: groupNameLabel.rx.text)
            .disposed(by: disposeBag)

        reactor.state.map { $0.groupSummary.groupDescription }
            .distinctUntilChanged()
            .bind(to: groupDescriptionLabel.rx.text)
            .disposed(by: disposeBag)

        reactor.state.map { ($0.groupSummary.restaurantCount, $0.groupSummary.memberCount) }
            .map { (restaurantCount, memberCount) in
                "\(restaurantCount)件のお店 / \(memberCount)人のメンバー"
            }
            .bind(to: groupSummaryLabel.rx.text)
            .disposed(by: disposeBag)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

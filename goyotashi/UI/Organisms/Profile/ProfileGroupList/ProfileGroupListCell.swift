//
//  ProfileGroupListCell.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/26.
//

import UIKit
import ReactorKit
import Kingfisher

final class ProfileGroupListCell: UICollectionViewCell, View, ViewConstructor {

    struct Const {
        static let aspectRatio: CGFloat = 1.35
        static let smallImageWidth: CGFloat = (DeviceSize.screenWidth - 32 - 8) / 3
        static let smallImageHeight: CGFloat = smallImageWidth / aspectRatio
        static let smallImageSize: CGSize = CGSize(width: smallImageWidth, height: smallImageHeight)
        static let largeImageWidth: CGFloat = smallImageWidth * 2 + 4
        static let largeImageHeight: CGFloat = smallImageHeight * 2 + 4
        static let imagesViewHeight: CGFloat = smallImageHeight * 3 + 8
        static let cellWidth: CGFloat = DeviceSize.screenWidth - 32
        static let cellHeight: CGFloat = smallImageHeight * 3 + 8 + 60
        static let itemSize: CGSize = CGSize(width: cellWidth, height: cellHeight)
    }

    // MARK: - Variables
    var disposeBag = DisposeBag()

    // MARK: - Views
    private let imagesView = UIView().then {
        $0.layer.cornerRadius = 16
        $0.layer.masksToBounds = true
    }

    private let largeImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.image = R.image.dish()
    }

    private let smallImageViews: [UIImageView] = {
        var imageViews: [UIImageView] = (0 ..< 5).map { _ in
            let imageView = UIImageView().then {
                $0.contentMode = .scaleAspectFill
                $0.clipsToBounds = true
                $0.image = R.image.dish()
            }
            return imageView
        }
        return imageViews
    }()

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

    // MARK: - Functions
    func clearImage() {
        largeImageView.image = R.image.dish()
        smallImageViews.forEach { imageView in
            imageView.image = R.image.dish()
        }
    }

    // MARK: - Setup Methods
    func setupViews() {
        imagesView.addSubview(largeImageView)
        _ = smallImageViews.map {
            imagesView.addSubview($0)
        }
        contentView.addSubview(imagesView)
        contentView.addSubview(groupNameLabel)
        contentView.addSubview(descriptionLabel)
    }

    func setupViewConstraints() {
        imagesView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(Const.imagesViewHeight)
        }
        largeImageView.snp.makeConstraints {
            $0.top.left.equalToSuperview()
            $0.width.equalTo(Const.largeImageWidth)
            $0.height.equalTo(Const.largeImageHeight)
        }
        smallImageViews[0].snp.makeConstraints {
            $0.top.right.equalToSuperview()
            $0.size.equalTo(Const.smallImageSize)
        }
        smallImageViews[1].snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.bottom.equalTo(largeImageView)
            $0.size.equalTo(Const.smallImageSize)
        }
        smallImageViews[2].snp.makeConstraints {
            $0.left.bottom.equalToSuperview()
            $0.size.equalTo(Const.smallImageSize)
        }
        smallImageViews[3].snp.makeConstraints {
            $0.left.equalTo(smallImageViews[2].snp.right).offset(4)
            $0.bottom.equalToSuperview()
            $0.size.equalTo(Const.smallImageSize)
        }
        smallImageViews[4].snp.makeConstraints {
            $0.right.bottom.equalToSuperview()
            $0.size.equalTo(Const.smallImageSize)
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
    func bind(reactor: ProfileGroupListCellReactor) {
        // Action

        // State
        reactor.state.map { $0.groupSummary.imageUrls }
            .distinctUntilChanged()
            .bind { [weak self] imageUrls in
                self?.clearImage()
                let max = min(imageUrls.count, 6)
                for index in 0 ..< max {
                    if index == 0 {
                        self?.largeImageView.kf.setImage(with: URL(string: imageUrls[0]), placeholder: R.image.dish())
                    } else {
                        self?.smallImageViews[index - 1].kf.setImage(with: URL(string: imageUrls[index]), placeholder: R.image.dish())
                    }
                }
            }
            .disposed(by: disposeBag)

        reactor.state.map { $0.groupSummary.groupName }
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

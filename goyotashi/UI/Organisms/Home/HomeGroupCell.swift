//
//  HomeGroupCell.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/25.
//

import UIKit
import ReactorKit
import Kingfisher

final class HomeGroupCell: UICollectionViewCell, View, ViewConstructor {

    struct Const {
        static let largeImageSize: CGFloat = (DeviceSize.screenWidth - 32 - 4) / 2
        static let smallImageSize: CGFloat = (largeImageSize - 4) / 2
        static let cellWidth: CGFloat = DeviceSize.screenWidth - 32
        static let cellHeight: CGFloat = largeImageSize + 74
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
        $0.contentMode = .scaleToFill
        $0.clipsToBounds = true
        $0.image = R.image.dish()
    }

    private let smallImageViews: [UIImageView] = {
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

    private let groupNameLabel = UILabel().then {
        $0.apply(fontStyle: .bold, size: 16, color: Color.gray01)
    }

    private let descriptionLabel = UILabel().then {
        $0.apply(fontStyle: .medium, size: 14, color: Color.gray03)
        $0.numberOfLines = 2
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
            $0.height.equalTo(Const.largeImageSize)
        }
        largeImageView.snp.makeConstraints {
            $0.top.left.bottom.equalToSuperview()
            $0.size.equalTo(Const.largeImageSize)
        }
        smallImageViews[0].snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalTo(largeImageView.snp.right).offset(4)
            $0.size.equalTo(Const.smallImageSize)
        }
        smallImageViews[1].snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.right.equalToSuperview()
            $0.size.equalTo(Const.smallImageSize)
        }
        smallImageViews[2].snp.makeConstraints {
            $0.left.equalTo(largeImageView.snp.right).offset(4)
            $0.bottom.equalToSuperview()
            $0.size.equalTo(Const.smallImageSize)
        }
        smallImageViews[3].snp.makeConstraints {
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
    func bind(reactor: HomeGroupCellReactor) {
        // Action

        // State
        reactor.state.map { $0.groupSummary.imageUrls }
            .distinctUntilChanged()
            .bind { [weak self] imageUrls in
                self?.clearImage()
                let max = min(imageUrls.count, 5)
                for index in 0 ..< max {
                    if index == 0 {
                        self?.largeImageView.setImageWithHPGUrl(urlString: imageUrls[0])
                    } else {
                        self?.smallImageViews[index - 1].setImageWithHPGUrl(urlString: imageUrls[index])
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

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
    }

    // MARK: - Bind Method
    func bind(reactor: AddRestaurantToGroupCellReactor) {
        // Action

        // State
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

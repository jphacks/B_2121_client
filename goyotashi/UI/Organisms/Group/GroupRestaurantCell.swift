//
//  GroupRestaurantCell.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/26.
//

import UIKit
import ReactorKit
import Kingfisher

final class GroupRestaurantCell: UICollectionViewCell, View, ViewConstructor {

    struct Const {
        static let aspectRatio: CGFloat = 1.42
        static let imageViewWidth: CGFloat = (DeviceSize.screenWidth - 32 - 8) / 2
        static let imageViewHeight: CGFloat = imageViewWidth / aspectRatio
        static let cellWidth: CGFloat = imageViewWidth
        static let cellHeight: CGFloat = imageViewHeight + 28
        static let itemSize: CGSize = CGSize(width: cellWidth, height: cellHeight)
    }

    // MARK: - Variables
    var disposeBag = DisposeBag()

    // MARK: - Views
    private let imageView = UIView().then {
        $0.layer.cornerRadius = 16
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
        contentView.addSubview(imageView)
    }

    func setupViewConstraints() {
        imageView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(Const.imageViewHeight)
        }
    }

    // MARK: - Bind Method
    func bind(reactor: GroupRestaurantCellReactor) {
        // Action

        // State
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

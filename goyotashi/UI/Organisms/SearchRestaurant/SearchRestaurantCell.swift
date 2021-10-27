//
//  SearchRestaurantCell.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/27.
//

import UIKit
import ReactorKit
import Kingfisher

final class SearchRestaurantCell: UICollectionViewCell, View, ViewConstructor {

    struct Const {
        static let imageViewSize: CGFloat = 128
        static let cellWidth: CGFloat = DeviceSize.screenWidth
        static let cellHeight: CGFloat = imageViewSize + 16
        static let itemSize: CGSize = CGSize(width: cellWidth, height: cellHeight)
    }

    // MARK: - Variables
    var disposeBag = DisposeBag()

    // MARK: - Views
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.image = R.image.dish()
        $0.layer.cornerRadius = 16
        $0.layer.masksToBounds = true
    }

    private let stackView = UIStackView().then {
        $0.axis = .vertical
    }

    private let restaurantNameLabel = UILabel().then {
        $0.apply(fontStyle: .bold, size: 16, color: Color.gray01)
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
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(restaurantNameLabel)
    }

    func setupViewConstraints() {
        imageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(16)
            $0.size.equalTo(Const.imageViewSize)
        }
        stackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.left.equalTo(imageView.snp.right).offset(8)
            $0.right.equalToSuperview().inset(16)
        }
    }

    // MARK: - Bind Method
    func bind(reactor: SearchRestaurantCellReactor) {
        // Action

        // State
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

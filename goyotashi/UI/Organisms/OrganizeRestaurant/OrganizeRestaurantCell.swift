//
//  OrganizeRestaurantCell.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/27.
//

import UIKit
import ReactorKit
import Kingfisher

final class OrganizeRestaurantCell: UICollectionViewCell, View, ViewConstructor {

    struct Const {
        static let aspectRatio: CGFloat = 1.42
        static let imageViewWidth: CGFloat = (DeviceSize.screenWidth - 32 - 8) / 2
        static let imageViewHeight: CGFloat = imageViewWidth / aspectRatio
        static let cellWidth: CGFloat = imageViewWidth
        static let cellHeight: CGFloat = imageViewHeight + 28
        static let itemSize: CGSize = CGSize(width: cellWidth, height: cellHeight)
        static let removeIconViewSize: CGFloat = 32
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

    private let overlayView = UIView().then {
        $0.backgroundColor = Color.white.withAlphaComponent(0.8)
        $0.isHidden = true
    }

    private let removeIconView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = R.image.remove()
    }

    private let restaurantNameLabel = UILabel().then {
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
        contentView.addSubview(imageView)
        imageView.addSubview(overlayView)
        overlayView.addSubview(removeIconView)
        contentView.addSubview(restaurantNameLabel)
    }

    func setupViewConstraints() {
        imageView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(Const.imageViewHeight)
            $0.width.equalTo(Const.imageViewWidth)
        }
        overlayView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        removeIconView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(Const.removeIconViewSize)
        }
        restaurantNameLabel.snp.makeConstraints {
            $0.left.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview()
        }
    }

    // MARK: - Bind Method
    func bind(reactor: OrganizeRestaurantCellReactor) {
        // Action

        // State
        reactor.state.map { $0.groupRestaurant.imageUrl }
            .distinctUntilChanged()
            .bind { [weak self] urlString in
                self?.imageView.setImageWithHPGUrl(urlString: urlString)
            }
            .disposed(by: disposeBag)

        reactor.state.map { $0.groupRestaurant.restaurantName }
            .distinctUntilChanged()
            .bind(to: restaurantNameLabel.rx.text)
            .disposed(by: disposeBag)

        reactor.state.map { $0.isRemovable }
            .distinctUntilChanged()
            .map { !$0 }
            .bind(to: overlayView.rx.isHidden)
            .disposed(by: disposeBag)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

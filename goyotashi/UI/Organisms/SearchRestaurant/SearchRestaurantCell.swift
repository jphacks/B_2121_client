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
        $0.numberOfLines = 0
    }

    private let descriptionLabel = UILabel().then {
        $0.apply(fontStyle: .regular, size: 13, color: Color.gray03)
        $0.numberOfLines = 0
    }

    private let addressLabel = UILabel().then {
        $0.apply(fontStyle: .regular, size: 12, color: Color.gray02)
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
        contentView.addSubview(imageView)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(restaurantNameLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.setCustomSpacing(8, after: descriptionLabel)
        stackView.addArrangedSubview(addressLabel)
    }

    func setupViewConstraints() {
        imageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(16)
            $0.size.equalTo(Const.imageViewSize)
        }
        stackView.snp.makeConstraints {
            $0.top.greaterThanOrEqualToSuperview().inset(8)
            $0.bottom.lessThanOrEqualToSuperview().inset(8)
            $0.centerY.equalToSuperview()
            $0.left.equalTo(imageView.snp.right).offset(8)
            $0.right.equalToSuperview().inset(16)
        }
    }

    // MARK: - Bind Method
    func bind(reactor: SearchRestaurantCellReactor) {
        // Action

        // State
        reactor.state.map { $0.restaurant.imageUrl }
            .distinctUntilChanged()
            .filterNil()
            .bind { [weak self] urlString in
                self?.imageView.setImageWithHPGUrl(urlString: urlString, sizeType: .medium)
            }
            .disposed(by: disposeBag)

        reactor.state.map { $0.restaurant.name }
            .distinctUntilChanged()
            .bind(to: restaurantNameLabel.rx.text)
            .disposed(by: disposeBag)

        reactor.state.map { $0.restaurant.description }
            .distinctUntilChanged()
            .bind(to: descriptionLabel.rx.text)
            .disposed(by: disposeBag)

        reactor.state.map { $0.restaurant.address }
            .distinctUntilChanged()
            .bind(to: addressLabel.rx.text)
            .disposed(by: disposeBag)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

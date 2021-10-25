//
//  HomeGroupCell.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/25.
//

import UIKit
import ReactorKit

final class HomeGroupCell: UICollectionViewCell, View, ViewConstructor {

    struct Const {
        static let cellWidth: CGFloat = DeviceSize.screenWidth - 32
        static let cellHeight: CGFloat = 320
        static let itemSize: CGSize = CGSize(width: cellWidth, height: cellHeight)
    }

    // MARK: - Variables
    var disposeBag = DisposeBag()

    // MARK: - Views
    private let imagesView = UIView().then {
        $0.layer.cornerRadius = 16
        $0.layer.masksToBounds = true
        $0.backgroundColor = Color.gray06
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
        contentView.addSubview(imagesView)
    }

    func setupViewConstraints() {
        imagesView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }

    // MARK: - Bind Method
    func bind(reactor: HomeGroupCellReactor) {
        // Action

        // State
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

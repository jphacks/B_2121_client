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
    }

    // MARK: - Variables
    var disposeBag = DisposeBag()

    // MARK: - Views

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
    }

    func setupViewConstraints() {
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

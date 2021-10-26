//
//  OrganizeRestaurantViewController.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/27.
//

import UIKit
import ReactorKit
import ReusableKit

final class OrganizeRestaurantViewController: UIViewController, View, ViewConstructor {

    struct Reusable {
        static let restaurantCell = ReusableCell<OrganizeRestaurantCell>()
    }

    // MARK: - Variables
    var disposeBag = DisposeBag()

    // MARK: - Views
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.estimatedItemSize =  OrganizeRestaurantCell.Const.itemSize
        $0.minimumLineSpacing = 24
        $0.minimumInteritemSpacing = 8
        $0.scrollDirection = .vertical
    }).then {
        $0.register(Reusable.restaurantCell)
        $0.contentInset = UIEdgeInsets(top: 24, left: 16, bottom: 56, right: 16)
        $0.backgroundColor = Color.white
        $0.alwaysBounceVertical = true
    }

    // MARK: - Lify Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupViewConstraints()
    }

    // MARK: - Setup Methods
    func setupViews() {
        title = "お店を整理する"
        view.addSubview(collectionView)
    }

    func setupViewConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: - Bind Method
    func bind(reactor: OrganizeRestaurantReactor) {
        // Action

        // State
        reactor.state.map { $0.restaurantCellReactors }
            .distinctUntilChanged()
            .bind(to: collectionView.rx.items(Reusable.restaurantCell)) { _, reactor, cell in
                cell.reactor = reactor
            }
            .disposed(by: disposeBag)
    }
}

//
//  SearchRestaurantResultViewController.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/27.
//

import UIKit
import ReactorKit
import ReusableKit

final class SearchRestaurantResultViewController: UIViewController, View, ViewConstructor {

    struct Reusable {
        static let restaurantCell = ReusableCell<SearchRestaurantCell>()
    }

    // MARK: - Variables
    var disposeBag = DisposeBag()

    // MARK: - Views
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.itemSize =  SearchRestaurantCell.Const.itemSize
        $0.minimumLineSpacing = 0
        $0.scrollDirection = .vertical
    }).then {
        $0.register(Reusable.restaurantCell)
        $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 56, right: 0)
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
        view.addSubview(collectionView)
    }

    func setupViewConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: - Bind Method
    func bind(reactor: SearchRestaurantResultReactor) {
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

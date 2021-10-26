//
//  RestaurantViewController.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/26.
//

import UIKit
import ReactorKit
import ReusableKit

final class RestaurantViewController: UIViewController, View, ViewConstructor {

    struct Reusable {
        static let groupCell = ReusableCell<RestaurantOtherGroupCell>()
    }

    // MARK: - Variables
    var disposeBag = DisposeBag()

    // MARK: - Views
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.estimatedItemSize =  ProfileGroupListCell.Const.itemSize
        $0.minimumLineSpacing = 32
        $0.scrollDirection = .vertical
    }).then {
        $0.register(Reusable.groupCell)
        $0.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 56, right: 16)
        $0.backgroundColor = Color.white
        $0.alwaysBounceVertical = true
    }

    private let header = RestaurantHeaderView()

    // MARK: - Lify Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupViewConstraints()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let height = header.frame.height
        collectionView.contentInset.top = height
        header.snp.remakeConstraints {
            $0.top.equalToSuperview().offset(-height)
            $0.left.right.equalTo(view)
        }

        let topInset = collectionView.adjustedContentInset.top
        collectionView.setContentOffset(CGPoint(x: -16, y: -topInset), animated: false)
    }

    // MARK: - Setup Methods
    func setupViews() {
        view.addSubview(collectionView)
        collectionView.addSubview(header)
    }

    func setupViewConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        header.snp.makeConstraints {
            $0.left.right.equalTo(view)
        }
    }

    // MARK: - Bind Method
    func bind(reactor: RestaurantReactor) {
        header.reactor = reactor

        // Action

        // State
        reactor.state.map { $0.groupCellReactors }
            .distinctUntilChanged()
            .bind(to: collectionView.rx.items(Reusable.groupCell)) { _, reactor, cell in
                cell.reactor = reactor
            }
            .disposed(by: disposeBag)
    }
}

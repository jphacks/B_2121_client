//
//  SearchGroupResultViewController.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/27.
//

import UIKit
import ReactorKit
import ReusableKit

final class SearchGroupResultViewController: UIViewController, View, ViewConstructor {

    struct Reusable {
        static let groupCell = ReusableCell<HomeGroupCell>()
    }

    // MARK: - Variables
    var disposeBag = DisposeBag()

    // MARK: - Views
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.itemSize =  HomeGroupCell.Const.itemSize
        $0.minimumLineSpacing = 32
        $0.scrollDirection = .vertical
        $0.sectionInset.top = SearchGroupResultHeaderView.Const.height
    }).then {
        $0.register(Reusable.groupCell)
        $0.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 56, right: 16)
        $0.backgroundColor = Color.white
        $0.alwaysBounceVertical = true
    }

    private let header = SearchGroupResultHeaderView()

    // MARK: - Lify Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupViewConstraints()
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
            $0.top.equalToSuperview()
            $0.left.right.equalTo(view)
        }
    }

    // MARK: - Bind Method
    func bind(reactor: SearchGroupResultReactor) {
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

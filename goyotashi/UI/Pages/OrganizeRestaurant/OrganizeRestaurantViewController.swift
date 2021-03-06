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
    private let closeButton = UIButton().then {
        $0.setImage(R.image.close(), for: .normal)
    }

    private let removeButton = UIBarButtonItem(title: "削除", style: .done, target: nil, action: nil).then {
        $0.tintColor = Color.red
    }

    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.itemSize =  OrganizeRestaurantCell.Const.itemSize
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: closeButton)
        navigationItem.rightBarButtonItem = removeButton

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
        reactor.action.onNext(.refresh)

        closeButton.rx.tap
            .bind { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            }
            .disposed(by: disposeBag)

        removeButton.rx.tap
            .map { Reactor.Action.remove }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        collectionView.rx.itemSelected
            .map { Reactor.Action.didSelectItem($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        // State
        reactor.state.map { $0.restaurantCellReactors }
            .distinctUntilChanged()
            .bind(to: collectionView.rx.items(Reusable.restaurantCell)) { _, reactor, cell in
                cell.reactor = reactor
            }
            .disposed(by: disposeBag)

        reactor.state.map { $0.apiStatus }
            .distinctUntilChanged()
            .bind { [weak self] apiStatus in
                if apiStatus == .succeeded {
                    self?.dismiss(animated: true, completion: nil)
                }
                if apiStatus == .failed {
                    logger.error("failed to create a group")
                }
            }
            .disposed(by: disposeBag)
    }
}

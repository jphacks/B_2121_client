//
//  RestaurantViewController.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/26.
//

import UIKit
import ReactorKit
import ReusableKit
import RxGesture

final class RestaurantViewController: UIViewController, ReactorKit.View, ViewConstructor {

    struct Reusable {
        static let groupCell = ReusableCell<RestaurantOtherGroupCell>()
    }

    // MARK: - Variables
    var disposeBag = DisposeBag()

    var didConfigureHeader: Bool = false

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

        if didConfigureHeader { return }
        let height = header.frame.height
        if height == 0 { return }
        configureHeader(height: height)
    }

    private func configureHeader(height: CGFloat) {
        didConfigureHeader = true
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
        title = "お店"
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
        reactor.action.onNext(.refresh)

        header.addRestaurantButton.rx.tap
            .bind { [weak self] _ in
                let viewController = AddRestaurantToGroupViewController().then {
                    $0.reactor = reactor.createAddRestaurantToGroupReactor()
                }
                let navController = UINavigationController(rootViewController: viewController)
                self?.present(navController, animated: true, completion: nil)
            }
            .disposed(by: disposeBag)

        header.mapView.rx.tapGesture()
            .when(.ended)
            .bind { [weak self] _ in
                let restaurantName = reactor.currentState.restaurant.name
                let location = reactor.currentState.restaurant.location
                let viewController = RestaurantMapViewController(restaurantName: restaurantName, location: location)
                self?.navigationController?.pushViewController(viewController, animated: true)
            }
            .disposed(by: disposeBag)

        // State
        reactor.state.map { $0.groupCellReactors }
            .distinctUntilChanged()
            .bind(to: collectionView.rx.items(Reusable.groupCell)) { _, reactor, cell in
                cell.reactor = reactor
            }
            .disposed(by: disposeBag)
    }
}

//
//  GroupViewController.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/26.
//

import UIKit
import ReactorKit
import ReusableKit

final class GroupViewController: UIViewController, View, ViewConstructor {

    struct Reusable {
        static let restaurantCell = ReusableCell<GroupRestaurantCell>()
    }

    // MARK: - Variables
    var disposeBag = DisposeBag()

    // MARK: - Views
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.estimatedItemSize =  GroupRestaurantCell.Const.itemSize
        $0.minimumLineSpacing = 24
        $0.minimumInteritemSpacing = 8
        $0.scrollDirection = .vertical
    }).then {
        $0.register(Reusable.restaurantCell)
        $0.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 56, right: 16)
        $0.backgroundColor = Color.white
        $0.alwaysBounceVertical = true
    }

    private let header = GroupHeaderView()

    // MARK: - Lify Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupViewConstraints()
    }

    // MARK: - Setup Methods
    func setupViews() {
        title = "グループ"
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

    func setupHeaderHeight() {
        // TODO: fix layout collapse
        let height = header.frame.height + 100
        collectionView.contentInset.top = height
        header.snp.remakeConstraints {
            $0.top.equalToSuperview().offset(-height)
            $0.left.right.equalTo(view)
        }

        let topInset = collectionView.adjustedContentInset.top
        collectionView.setContentOffset(CGPoint(x: -16, y: -topInset), animated: false)
    }

    // MARK: - Bind Method
    func bind(reactor: GroupReactor) {
        header.reactor = reactor

        // Action
        reactor.action.onNext(.refresh)

        header.groupMemberButton.rx.tap
            .bind { [weak self] _ in
                let viewController = MemberListViewController().then {
                    $0.reactor = reactor.memberListReactor()
                }
                let navController = UINavigationController(rootViewController: viewController).then {
                    $0.modalPresentationStyle = .fullScreen
                }
                self?.present(navController, animated: true, completion: nil)
            }
            .disposed(by: disposeBag)

        header.organizeButton.rx.tap
            .bind { [weak self] _ in
                let viewController = OrganizeRestaurantViewController().then {
                    $0.reactor = reactor.createOrganizeRestaurantReactor()
                }
                let navController = UINavigationController(rootViewController: viewController).then {
                    $0.modalPresentationStyle = .fullScreen
                }
                self?.present(navController, animated: true, completion: nil)
            }
            .disposed(by: disposeBag)

        header.editButton.rx.tap
            .bind { [weak self] _ in
                let viewController = EditGroupViewController().then {
                    $0.reactor = reactor.createEditGroupReactor()
                }
                let navController = UINavigationController(rootViewController: viewController).then {
                    $0.modalPresentationStyle = .fullScreen
                }
                self?.present(navController, animated: true, completion: nil)
            }
            .disposed(by: disposeBag)

        header.addMemberButton.rx.tap
            .bind { [weak self] _ in
                let viewController = InviteMemberViewController().then {
                    $0.reactor = reactor.createInviteMemberReactor()
                }
                let navController = UINavigationController(rootViewController: viewController).then {
                    $0.modalPresentationStyle = .fullScreen
                }
                self?.present(navController, animated: true, completion: nil)
            }
            .disposed(by: disposeBag)

        header.bookmarkButton.rx.tap
            .map { Reactor.Action.tapBookmarkButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        header.plusButton.rx.tap
            .bind { [weak self] _ in
                let viewController = SearchRestaurantViewController().then {
                    $0.reactor = reactor.createSearchRestaurantReactor()
                }
                let navController = UINavigationController(rootViewController: viewController).then {
                    $0.modalPresentationStyle = .fullScreen
                }
                self?.present(navController, animated: true, completion: nil)
            }
            .disposed(by: disposeBag)

        collectionView.rx.itemSelected
            .bind { [weak self] indexPath in
                let viewController = RestaurantViewController().then {
                    $0.reactor = reactor.createRestaurantReactor(indexPath: indexPath)
                }
                self?.navigationController?.pushViewController(viewController, animated: true)
            }
            .disposed(by: disposeBag)

        // State
        reactor.state.map { $0.restaurantCellReactors }
            .distinctUntilChanged()
            .bind(to: collectionView.rx.items(Reusable.restaurantCell)) { _, reactor, cell in
                cell.reactor = reactor
            }
            .disposed(by: disposeBag)

        reactor.state.map { $0.group }
            .filterNil()
            .bind { [weak self] _ in
                self?.setupHeaderHeight()
            }
            .disposed(by: disposeBag)

        reactor.state.map { $0.isBookmarked }
            .distinctUntilChanged()
            .bind(to: header.bookmarkButton.rx.isSelected)
            .disposed(by: disposeBag)
    }
}

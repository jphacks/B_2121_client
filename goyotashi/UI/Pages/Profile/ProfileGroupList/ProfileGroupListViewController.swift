//
//  ProfileGroupListViewController.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/26.
//

import UIKit
import ReactorKit
import ReusableKit
import SegementSlide

final class ProfileGroupListViewController: UIViewController, View, ViewConstructor {

    struct Reusable {
        static let groupCell = ReusableCell<ProfileGroupListCell>()
    }

    // MARK: - Variables
    var disposeBag = DisposeBag()

    // MARK: - Views
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.estimatedItemSize =  ProfileGroupListCell.Const.itemSize
        $0.minimumLineSpacing = 32
        $0.scrollDirection = .vertical
        $0.headerReferenceSize = CGSize(width: DeviceSize.screenWidth, height: 24)
    }).then {
        $0.register(Reusable.groupCell)
        $0.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 56, right: 16)
        $0.backgroundColor = Color.white
        $0.alwaysBounceVertical = true
    }

    let refreshControl = UIRefreshControl().then {
        $0.tintColor = Color.gray05
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
        collectionView.refreshControl = refreshControl
    }

    func setupViewConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: - Bind Method
    func bind(reactor: ProfileGroupListReactor) {
        // Action
        reactor.action.onNext(.refresh)

        refreshControl.rx.controlEvent(.valueChanged)
            .bind { reactor.action.onNext(.refresh) }
            .disposed(by: disposeBag)

        collectionView.rx.itemSelected
            .bind { [weak self] indexPath in
                let viewController = GroupViewController().then {
                    $0.reactor = reactor.createGroupReactor(indexPath: indexPath)
                }
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

        reactor.state.map { $0.apiStatus }
            .distinctUntilChanged()
            .bind { [weak self] apiStatus in
                switch apiStatus {
                case .refreshing:
                    self?.refreshControl.beginRefreshing()
                case .pending:
                    self?.refreshControl.endRefreshing()
                default:
                    break
                }
            }
            .disposed(by: disposeBag)
    }
}

extension ProfileGroupListViewController: SegementSlideContentScrollViewDelegate {
    @objc var scrollView: UIScrollView {
        return collectionView
    }
}

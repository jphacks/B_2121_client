//
//  InviteMemberViewController.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/27.
//

import UIKit
import ReactorKit
import ReusableKit

final class InviteMemberViewController: UIViewController, View, ViewConstructor {

    struct Reusable {
        static let memberCell = ReusableCell<InviteMemberCell>()
    }

    // MARK: - Variables
    var disposeBag = DisposeBag()

    // MARK: - Views
    private let searchBar = UISearchBar().then {
        $0.placeholder = "キーワード"
        $0.backgroundImage = UIImage()
        $0.tintColor = Color.gray01
    }

    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.itemSize =  InviteMemberCell.Const.itemSize
        $0.minimumLineSpacing = 0
        $0.scrollDirection = .vertical
    }).then {
        $0.register(Reusable.memberCell)
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

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        searchBar.snp.remakeConstraints {
            $0.top.equalToSuperview().inset(view.safeAreaInsets.top)
            $0.left.right.equalToSuperview()
        }
    }

    // MARK: - Setup Methods
    func setupViews() {
        view.backgroundColor = Color.white

        view.addSubview(searchBar)
        view.addSubview(collectionView)
    }

    func setupViewConstraints() {
        searchBar.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
    }

    // MARK: - Bind Method
    func bind(reactor: InviteMemberReactor) {
        // Action

        // State
        reactor.state.map { $0.memberCellReactors }
            .distinctUntilChanged()
            .bind(to: collectionView.rx.items(Reusable.memberCell)) { _, reactor, cell in
                cell.reactor = reactor
            }
            .disposed(by: disposeBag)
    }
}

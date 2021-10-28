//
//  MemberListViewContoroller.swift
//  goyotashi
//
//  Created by 山河絵利奈 on 2021/10/27.
//

import UIKit
import ReactorKit
import ReusableKit

final class MemberListViewController: UIViewController, View, ViewConstructor {

    struct Reusable {
        static let memberCell = ReusableCell<MemberCell>()
    }

    // MARK: - Variables
    var disposeBag = DisposeBag()

    // MARK: - Views
    private let closeButton = UIButton().then {
        $0.setImage(R.image.close(), for: .normal)
    }

    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.itemSize =  MemberCell.Const.itemSize
        $0.scrollDirection = .vertical
    }).then {
        $0.register(Reusable.memberCell)
        $0.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 56, right: 16)
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

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: closeButton)

        view.backgroundColor = Color.white
        title = "メンバー"
    }

    func setupViewConstraints() {
        collectionView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.right.equalToSuperview().inset(16)
        }
    }

    // MARK: - Bind Method
    func bind(reactor: MemberListReactor) {
        // Action
        reactor.action.onNext(.refresh)

        closeButton.rx.tap
            .bind { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            }
            .disposed(by: disposeBag)

        // State
        reactor.state.map { $0.memberCellReactors }
            .distinctUntilChanged()
            .bind(to: collectionView.rx.items(Reusable.memberCell)) { _, reactor, cell in
                cell.reactor = reactor
            }
            .disposed(by: disposeBag)
    }
}

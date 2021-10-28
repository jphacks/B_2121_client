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

    // 出ない
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.estimatedItemSize =  MemberCell.Const.itemSize
        $0.minimumLineSpacing = 24
        $0.minimumInteritemSpacing = 8
        $0.scrollDirection = .vertical
    }).then {
        $0.register(Reusable.memberCell)
        $0.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 56, right: 16)
        $0.backgroundColor = Color.white
        $0.alwaysBounceVertical = true
    }

    // 出ない
    private let memberNameLabel = UILabel().then {
        $0.apply(fontStyle: .medium, size: 14, color: Color.gray01)
        $0.text="aaa"
    }

    // MARK: - Lify Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupViewConstraints()

        // これは出る
        let label = UILabel()
        label.text = "Swift"
        label.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        label.textColor = UIColor.red

        view.addSubview(label)
    }

    // MARK: - Setup Methods
    func setupViews() {
        view.addSubview(memberNameLabel)
        view.addSubview(collectionView)

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: closeButton)

        view.backgroundColor = Color.white
        title = "メンバー"
    }

    func setupViewConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        memberNameLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
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

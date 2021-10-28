//
//  AddRestaurantToGroupViewController.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/27.
//

import UIKit
import ReactorKit
import ReusableKit

final class AddRestaurantToGroupViewController: UIViewController, View, ViewConstructor {

    struct Reusable {
        static let groupCell = ReusableCell<AddRestaurantToGroupCell>()
    }

    // MARK: - Variables
    var disposeBag = DisposeBag()

    // MARK: - Views
    private let closeButton = UIButton().then {
        $0.setImage(R.image.close(), for: .normal)
    }

    private let doneButton = UIBarButtonItem(title: "完了", style: .done, target: nil, action: nil).then {
        $0.tintColor = Color.gray01
    }

    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.itemSize =  AddRestaurantToGroupCell.Const.itemSize
        $0.minimumLineSpacing = 16
        $0.scrollDirection = .vertical
    }).then {
        $0.register(Reusable.groupCell)
        $0.contentInset = UIEdgeInsets(top: 64, left: 16, bottom: 56, right: 16)
        $0.backgroundColor = Color.white
        $0.alwaysBounceVertical = true
    }

    private let headerLabel = UILabel().then {
        $0.apply(fontStyle: .medium, size: 15, color: Color.gray02)
        $0.text = "参加してるグループ"
    }

    // MARK: - Lify Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupViewConstraints()
    }

    // MARK: - Setup Methods
    func setupViews() {
        title = "グループに追加する"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: closeButton)
        navigationItem.rightBarButtonItem = doneButton

        view.addSubview(collectionView)
        collectionView.addSubview(headerLabel)
    }

    func setupViewConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        headerLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(-40)
            $0.left.right.equalTo(view).inset(16)
        }
    }

    // MARK: - Bind Method
    func bind(reactor: AddRestaurantToGroupReactor) {
        // Action
        reactor.action.onNext(.refresh)

        closeButton.rx.tap
            .bind { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            }
            .disposed(by: disposeBag)

        doneButton.rx.tap
            .bind { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
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

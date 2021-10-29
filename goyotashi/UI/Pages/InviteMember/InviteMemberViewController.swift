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
    private let closeButton = UIButton().then {
        $0.setImage(R.image.close(), for: .normal)
    }

    private let doneButton = UIBarButtonItem(title: "完了", style: .done, target: nil, action: nil).then {
        $0.tintColor = Color.gray01
    }

    private let invitationLinkCopyView = InvitationLinkCopyView()

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
        $0.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 56, right: 0)
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

        invitationLinkCopyView.snp.remakeConstraints {
            $0.top.equalToSuperview().inset(view.safeAreaInsets.top)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(InvitationLinkCopyView.Const.height)
        }
    }

    // MARK: - Setup Methods
    func setupViews() {
        title = "メンバーを招待"
        view.backgroundColor = Color.white
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: closeButton)
        navigationItem.rightBarButtonItem = doneButton

        view.addSubview(invitationLinkCopyView)
        view.addSubview(searchBar)
        view.addSubview(collectionView)
    }

    func setupViewConstraints() {
        invitationLinkCopyView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
        searchBar.snp.makeConstraints {
            $0.top.equalTo(invitationLinkCopyView.snp.bottom)
            $0.left.right.equalToSuperview().inset(8)
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
    }

    // MARK: - Bind Method
    func bind(reactor: InviteMemberReactor) {
        // Action
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

        invitationLinkCopyView.linkCopyButton.rx.tap
            .map { _ in Reactor.Action.tapInvitationLinkButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        searchBar.rx.text
            .distinctUntilChanged()
            .map { Reactor.Action.updateKeyword($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        searchBar.rx.textDidBeginEditing
            .bind { [weak self] in
                self?.searchBar.setShowsCancelButton(true, animated: true)
            }
            .disposed(by: disposeBag)

        searchBar.rx.searchButtonClicked
            .bind { [weak self] in
                self?.searchBar.resignFirstResponder()
            }
            .disposed(by: disposeBag)

        searchBar.rx.cancelButtonClicked
            .bind { [weak self] in
                self?.searchBar.text = ""
                self?.searchBar.resignFirstResponder()
                self?.searchBar.setShowsCancelButton(false, animated: true)
            }
            .disposed(by: disposeBag)

        // State
        reactor.state.map { $0.getTokenApiStatus }
            .distinctUntilChanged()
            .bind { [weak self] apiStatus in
                switch apiStatus {
                case .pending:
                    self?.invitationLinkCopyView.activityIndicatorView.stopAnimating()
                case .loading:
                    self?.invitationLinkCopyView.activityIndicatorView.startAnimating()
                    self?.invitationLinkCopyView.doneImageView.isHidden = true
                case .succeeded:
                    self?.invitationLinkCopyView.doneImageView.isHidden = false
                    UIPasteboard.general.string = reactor.currentState.invitationToken
                default:
                    break
                }
            }
            .disposed(by: disposeBag)

        reactor.state.map { $0.memberCellReactors }
            .distinctUntilChanged()
            .bind(to: collectionView.rx.items(Reusable.memberCell)) { _, reactor, cell in
                cell.reactor = reactor
            }
            .disposed(by: disposeBag)
    }
}

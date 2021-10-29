//
//  SearchRestaurantViewController.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/27.
//

import UIKit
import ReactorKit

final class SearchRestaurantViewController: UIViewController, View, ViewConstructor {

    // MARK: - Variables
    var disposeBag = DisposeBag()

    // MARK: - Views
    private let closeButton = UIButton().then {
        $0.setImage(R.image.close(), for: .normal)
    }

    private let searchBar = UISearchBar().then {
        $0.placeholder = "キーワード"
        $0.backgroundImage = UIImage()
        $0.tintColor = Color.gray01
    }

    private lazy var searchRestaurantResultViewController = SearchRestaurantResultViewController()

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
            $0.left.right.equalToSuperview().inset(8)
        }
    }

    // MARK: - Setup Methods
    func setupViews() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: closeButton)
        title = "お店をグループに追加する"
        view.backgroundColor = Color.white

        view.addSubview(searchBar)

        addChild()
    }

    private func addChild() {
        addChild(searchRestaurantResultViewController)
        view.addSubview(searchRestaurantResultViewController.view)
        searchRestaurantResultViewController.didMove(toParent: self)
    }

    func setupViewConstraints() {
        searchBar.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
        searchRestaurantResultViewController.view.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
    }

    // MARK: - Bind Method
    func bind(reactor: SearchRestaurantReactor) {
        searchRestaurantResultViewController.reactor = reactor.createSearchRestaurantResultReactor()

        // Action
        closeButton.rx.tap
            .bind { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            }
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

        searchBar.rx.cancelButtonClicked
            .bind { [weak self] in
                self?.searchBar.text = ""
                self?.searchBar.resignFirstResponder()
                self?.searchBar.setShowsCancelButton(false, animated: true)
            }
            .disposed(by: disposeBag)

        // State
        reactor.state.map { $0.keyword }
            .distinctUntilChanged()
            .bind { [weak self] keyword in
                self?.searchRestaurantResultViewController.reactor?.action.onNext(.search(keyword))
            }
            .disposed(by: disposeBag)

        searchRestaurantResultViewController.reactor?.state
            .map {$0.apiStatus}
            .distinctUntilChanged()
            .bind { [weak self] apiStatus in
                if apiStatus == .succeeded {
                    self?.dismiss(animated: true, completion: nil)
                }
                if apiStatus == .failed {
                    logger.error("failed to add a restaurant to the group")
                }
            }
            .disposed(by: disposeBag)
    }
}

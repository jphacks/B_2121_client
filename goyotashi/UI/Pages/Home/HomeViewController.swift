//
//  HomeViewController.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/25.
//

import UIKit
import ReactorKit
import ReusableKit

final class HomeViewController: UIViewController, View, ViewConstructor {

    // MARK: - Variables
    var disposeBag = DisposeBag()

    // MARK: - Views
    private let searchBar = UISearchBar().then {
        $0.placeholder = "キーワードでグループを検索"
        $0.backgroundImage = UIImage()
        $0.tintColor = Color.gray01
    }

    private lazy var recommendGroupViewController = RecommendGroupViewController()
    private lazy var searchGroupResultViewController = SearchGroupResultViewController()

    // MARK: - Lify Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupViewConstraints()
    }

    // MARK: - Setup Methods
    func setupViews() {
        navigationItem.titleView = searchBar

        addChild()
    }

    private func addChild() {
        // RecommendGroupViewController
        addChild(recommendGroupViewController)
        view.addSubview(recommendGroupViewController.view)
        recommendGroupViewController.didMove(toParent: self)

        // SearchGroupResultViewController
        addChild(searchGroupResultViewController)
        view.addSubview(searchGroupResultViewController.view)
        searchGroupResultViewController.didMove(toParent: self)
    }

    func setupViewConstraints() {
        recommendGroupViewController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        searchGroupResultViewController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: - Bind Method
    func bind(reactor: HomeReactor) {
        recommendGroupViewController.reactor = reactor.createRecommendGroupReactor()
        searchGroupResultViewController.reactor = reactor.createSearchGroupResultReactor()

        // Action
        searchBar.rx.text
            .distinctUntilChanged()
            .bind { keyword in
                reactor.action.onNext(.updateKeyword(keyword))
            }
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
        reactor.state.map { $0.pageType }
            .distinctUntilChanged()
            .bind { [weak self] pageType in
                self?.recommendGroupViewController.view.isHidden = pageType != .recommendGroup
                self?.searchGroupResultViewController.view.isHidden = pageType != .searchGroupResult
            }
            .disposed(by: disposeBag)
    }
}

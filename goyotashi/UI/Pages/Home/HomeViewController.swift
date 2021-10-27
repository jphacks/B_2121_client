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
        addChild(recommendGroupViewController)
        view.addSubview(recommendGroupViewController.view)
        recommendGroupViewController.didMove(toParent: self)
    }

    func setupViewConstraints() {
        recommendGroupViewController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: - Bind Method
    func bind(reactor: HomeReactor) {
        recommendGroupViewController.reactor = reactor.createRecommendGroupReactor()

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
                print("search")
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
    }
}

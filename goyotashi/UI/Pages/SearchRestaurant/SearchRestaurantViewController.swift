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

    private let addButton = UIBarButtonItem(title: "追加", style: .done, target: nil, action: nil).then {
        $0.tintColor = Color.gray01
    }

    private let searchBar = UISearchBar().then {
        $0.placeholder = "キーワード"
        $0.backgroundImage = UIImage()
        $0.tintColor = Color.gray01
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
            $0.left.right.equalToSuperview().inset(8)
        }
    }

    // MARK: - Setup Methods
    func setupViews() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: closeButton)
        title = "お店をグループに追加する"
        navigationItem.rightBarButtonItem = addButton
        view.backgroundColor = Color.white

        view.addSubview(searchBar)
    }

    func setupViewConstraints() {
        searchBar.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
    }

    // MARK: - Bind Method
    func bind(reactor: SearchRestaurantReactor) {
        // Action
        closeButton.rx.tap
            .bind { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            }
            .disposed(by: disposeBag)

        // State
    }
}
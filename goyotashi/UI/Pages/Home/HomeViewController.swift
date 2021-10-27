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
    private lazy var recommendGroupViewController = RecommendGroupViewController()

    // MARK: - Lify Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupViewConstraints()
    }

    // MARK: - Setup Methods
    func setupViews() {
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

        // State
    }
}

//
//  OrganizeRestaurantViewController.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/27.
//

import UIKit
import ReactorKit

final class OrganizeRestaurantViewController: UIViewController, View, ViewConstructor {

    // MARK: - Variables
    var disposeBag = DisposeBag()

    // MARK: - Views

    // MARK: - Lify Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupViewConstraints()
    }

    // MARK: - Setup Methods
    func setupViews() {

    }

    func setupViewConstraints() {

    }

    // MARK: - Bind Method
    func bind(reactor: OrganizeRestaurantReactor) {
        // Action

        // State
    }
}

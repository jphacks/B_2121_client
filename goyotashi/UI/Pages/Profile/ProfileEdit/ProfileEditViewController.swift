//
//  ProfileEditViewController.swift
//  goyotashi
//
//  Created by 山河絵利奈 on 2021/10/29.
//

import UIKit
import ReactorKit
import SegementSlide

final class ProfileEditViewController: UIViewController {

    // MARK: - Variables
    var disposeBag = DisposeBag()

    // MARK: - Views

    // MARK: - Lify Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    // MARK: - Setup Methods
    func setupViews() {
        title = "プロフィール編集"
    }

    func setupViewConstraints() {}

    // MARK: - Bind Method
    func bind(reactor: ProfileReactor) {
        // Action

        // State
    }
}

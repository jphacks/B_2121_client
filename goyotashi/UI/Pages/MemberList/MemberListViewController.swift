//
//  MemberListViewContoroller.swift
//  goyotashi
//
//  Created by 山河絵利奈 on 2021/10/27.
//

import UIKit
import ReactorKit

final class MemberListViewController: UIViewController, View, ViewConstructor {

    // MARK: - Variables
    var disposeBag = DisposeBag()

    // MARK: - Views
    private let closeButton = UIButton().then {
        $0.setImage(R.image.close(), for: .normal)
    }

    // MARK: - Lify Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupViewConstraints()
    }

    // MARK: - Setup Methods
    func setupViews() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: closeButton)

        view.backgroundColor = Color.white
        title = "メンバー"
    }

    func setupViewConstraints() {
    }

    // MARK: - Bind Method
    func bind(reactor: MemberListReactor) {
        // Action
        closeButton.rx.tap
            .bind { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
    }
}

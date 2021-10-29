//
//  OnboardingViewController.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/30.
//

import UIKit
import ReactorKit

final class OnboardingViewController: UIViewController, View, ViewConstructor {

    // MARK: - Variables
    var disposeBag = DisposeBag()

    // MARK: - Views
    private let nameInputView = OnboardingNameInputView()

    // MARK: - Lify Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupViewConstraints()
    }

    // MARK: - Setup Methods
    func setupViews() {
        view.addSubview(nameInputView)
        view.backgroundColor = .orange
    }

    func setupViewConstraints() {
        nameInputView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: - Bind Method
    func bind(reactor: OnboardingReactor) {
        // Action
        nameInputView.nameTextField.rx.controlEvent(.editingDidEndOnExit)
            .bind { [weak self] _ in
                if let name = self?.nameInputView.nameTextField.text {
                    logger.debug(name)
                }
            }
            .disposed(by: disposeBag)

        // State
    }
}

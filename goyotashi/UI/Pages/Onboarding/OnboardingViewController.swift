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
        reactor.action.onNext(.createUser)

        nameInputView.nameTextField.rx.controlEvent(.editingDidEndOnExit)
            .bind { [weak self] _ in
                let name = self?.nameInputView.nameTextField.text
                reactor.action.onNext(.updateName(name))
            }
            .disposed(by: disposeBag)

        nameInputView.nameTextField.rx.text
            .bind { [weak self] text in
                self?.nameInputView.startButton.isEnabled = text != nil && text != ""
            }
            .disposed(by: disposeBag)

        // State
    }
}

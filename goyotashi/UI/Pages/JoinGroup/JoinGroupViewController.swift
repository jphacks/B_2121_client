//
//  JoinGroupViewController.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/30.
//

import UIKit
import ReactorKit

final class JoinGroupViewController: UIViewController, View, ViewConstructor {

    // MARK: - Variables
    var disposeBag = DisposeBag()

    // MARK: - Views
    private let closeButton = UIButton().then {
        $0.setImage(R.image.close(), for: .normal)
    }

    private let scrollView = UIScrollView().then {
        $0.alwaysBounceVertical = true
    }

    private let invitationCodeTitleLabel = UILabel().then {
        $0.apply(fontStyle: .regular, size: 15, color: Color.gray01)
        $0.text = "招待コード"
    }

    private let invitationCodeTextField = UITextField().then {
        $0.placeholder = "招待コードを入力"
        $0.font = UIFont(name: FontStyle.bold.rawValue, size: 18)
        $0.adjustsFontSizeToFitWidth = true
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

        view.addSubview(scrollView)
        scrollView.addSubview(invitationCodeTitleLabel)
        scrollView.addSubview(invitationCodeTextField)
    }

    func setupViewConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        invitationCodeTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.left.equalToSuperview().inset(16)
        }
        invitationCodeTextField.snp.makeConstraints {
            $0.top.equalTo(invitationCodeTitleLabel.snp.bottom).offset(8)
            $0.left.right.equalTo(view).inset(16)
        }
    }

    // MARK: - Bind Method
    func bind(reactor: JoinGroupReactor) {
        // Action
        closeButton.rx.tap
            .bind { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            }
            .disposed(by: disposeBag)

        // State
    }
}

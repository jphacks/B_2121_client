//
//  APIStatusView.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/29.
//

import UIKit
import RxSwift
import RxCocoa

final class APIStatusView: UIView, ViewConstructor {

    struct Const {
        static let messageViewSize: CGFloat = 160
        static let statusImageViewSize: CGFloat = 32
    }

    // MARK: - Views
    private let activityIndicatorView = UIActivityIndicatorView().then {
        $0.style = .large
    }

    private let messageView = UIView().then {
        $0.backgroundColor = Color.white
        $0.layer.cornerRadius = 16
        $0.layer.masksToBounds = true
    }

    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
    }

    private let statusImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }

    private let statusLabel = UILabel().then {
        $0.apply(fontStyle: .medium, size: 15, color: Color.gray02)
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.text = "失敗しちゃった...\nごめんね。"
    }

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: .zero)

        setupViews()
        setupViewConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Methods
    func setupViews() {
        addSubview(messageView)
        messageView.addSubview(activityIndicatorView)
        messageView.addSubview(stackView)
        stackView.addArrangedSubview(statusImageView)
        stackView.addArrangedSubview(statusLabel)

        backgroundColor = Color.gray01.withAlphaComponent(0.3)
    }

    func setupViewConstraints() {
        messageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(Const.messageViewSize)
        }
        activityIndicatorView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        statusImageView.snp.makeConstraints {
            $0.size.equalTo(Const.statusImageViewSize)
        }
    }

    func configure(apiStatus: APIStatus) {
        switch apiStatus {
        case .pending:
            isHidden = true
        case .refreshing:
            isHidden = true
        case .loading:
            isHidden = false
            activityIndicatorView.startAnimating()
        case .succeeded:
            isHidden = false
            activityIndicatorView.stopAnimating()
        case .failed:
            isHidden = false
            activityIndicatorView.stopAnimating()
        }
    }
}

extension Reactive where Base: APIStatusView {
    var apiStatus: Binder<APIStatus> {
        return Binder(base) { view, apiStatus in
            view.configure(apiStatus: apiStatus)
        }
    }
}

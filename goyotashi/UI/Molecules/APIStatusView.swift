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
    }

    // MARK: - Views
    private let activityIndicator = UIActivityIndicatorView().then {
        $0.style = .large
    }

    private let messageView = UIView().then {
        $0.backgroundColor = Color.white
        $0.layer.cornerRadius = 16
        $0.layer.masksToBounds = true
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
        messageView.addSubview(activityIndicator)

        backgroundColor = Color.gray01.withAlphaComponent(0.3)
    }

    func setupViewConstraints() {
        messageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(Const.messageViewSize)
        }
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
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
            activityIndicator.startAnimating()
        case .succeeded:
            isHidden = false
            activityIndicator.stopAnimating()
        case .failed:
            isHidden = false
            activityIndicator.stopAnimating()
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

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

    // MARK: - Views
    private let activityIndicator = UIActivityIndicatorView().then {
        $0.style = .large
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
        addSubview(activityIndicator)
    }

    func setupViewConstraints() {
        activityIndicator.snp.makeConstraints {
            $0.edges.equalToSuperview()
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

//
//  APIStatusView.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/29.
//

import UIKit

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
}

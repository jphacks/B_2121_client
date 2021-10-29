//
//  InvitationLinkCopyView.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/30.
//

import UIKit

final class InvitationLinkCopyView: UIView, ViewConstructor {
    struct Const {
        static let width: CGFloat = DeviceSize.screenWidth
        static let height: CGFloat = 64
        static let size: CGSize = CGSize(width: width, height: height)
    }

    // MARK: - Views
    private let linkImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = R.image.link()
    }

    let linkCopyButton = UIButton().then {
        $0.titleLabel?.apply(fontStyle: .medium, size: 16)
        $0.setTitle("招待コードをコピーする", for: .normal)
        $0.setTitleColor(Color.blue, for: .normal)
        $0.setTitleColor(Color.blue.withAlphaComponent(0.3), for: .highlighted)
    }

    private let activityIndicatorView = UIActivityIndicatorView().then {
        $0.startAnimating()
    }

    private let doneImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = R.image.check()
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
        addSubview(linkImageView)
        addSubview(linkCopyButton)
        addSubview(activityIndicatorView)
        addSubview(doneImageView)
    }

    func setupViewConstraints() {
        snp.makeConstraints {
            $0.size.equalTo(Const.size)
        }
        linkImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(24)
            $0.size.equalTo(32)
        }
        linkCopyButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(linkImageView.snp.right).offset(8)
            $0.height.equalTo(32)
            $0.width.equalTo(200)
        }
        activityIndicatorView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(32)
        }
        doneImageView.snp.makeConstraints {
            $0.center.equalTo(activityIndicatorView)
            $0.size.equalTo(24)
        }
    }
}

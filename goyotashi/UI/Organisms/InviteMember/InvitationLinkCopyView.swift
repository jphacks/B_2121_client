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
    }
}

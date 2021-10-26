//
//  OpenMapButton.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/26.
//

import UIKit

final class OpenMapButton: UIButton {
    struct Const {
        static let height: CGFloat = 40
        static let cornerRadius: CGFloat =  8
        static let iconSize: CGFloat = 16
    }

    override var isHighlighted: Bool {
        didSet {
        }
    }

    // MARK: - Views
    private let iconView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = R.image.location()
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)

        setupViews()
        setupViewConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        layer.cornerRadius = Const.cornerRadius
        backgroundColor = Color.gray06

        addSubview(iconView)
    }

    func setupViewConstraints() {
        snp.makeConstraints {
            $0.height.equalTo(Const.height)
        }
        iconView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.right.equalToSuperview().inset(12)
            $0.size.equalTo(Const.iconSize)
        }
    }
}

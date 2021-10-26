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

    private let actionNameLabel = UILabel().then {
        $0.apply(fontStyle: .medium, size: 11, color: Color.gray01)
        $0.text = "マップで開く"
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
        addSubview(actionNameLabel)
    }

    func setupViewConstraints() {
        snp.makeConstraints {
            $0.height.equalTo(Const.height)
        }
        iconView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(12)
            $0.size.equalTo(Const.iconSize)
        }
        actionNameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(iconView.snp.right).offset(4)
            $0.right.equalToSuperview().inset(16)
        }
    }
}

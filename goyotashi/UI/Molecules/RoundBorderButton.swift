//
//  RoundBorderButton.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/26.
//

import UIKit

final class RoundBorderButton: UIButton {
    struct Const {
        static let height: CGFloat = 40
        static let cornerRadius: CGFloat =  8
    }

    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? Color.gray06 : Color.white
        }
    }

    // MARK: - Views
    private let label = UILabel().then {
        $0.apply(fontStyle: .medium, size: 14, color: Color.gray01)
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
        layer.borderWidth = 1
        layer.borderColor = Color.gray05.cgColor
        layer.cornerRadius = Const.cornerRadius

        addSubview(label)
    }

    func setupViewConstraints() {
        snp.makeConstraints {
            $0.height.equalTo(Const.height)
        }
        label.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
    }

    func set(title: String) {
        label.text = title
    }
}

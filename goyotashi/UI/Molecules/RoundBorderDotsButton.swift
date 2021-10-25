//
//  RoundBorderDotsButton.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/26.
//

import UIKit

final class RoundBorderDotsButton: UIButton {
    struct Const {
        static let width: CGFloat = 48
        static let height: CGFloat = 40
        static let cornerRadius: CGFloat =  8
    }

    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? Color.gray06 : Color.white
        }
    }

    // MARK: - Views
    private let dotsImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = R.image.dots()
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

        addSubview(dotsImageView)
    }

    func setupViewConstraints() {
        snp.makeConstraints {
            $0.width.equalTo(Const.width)
            $0.height.equalTo(Const.height)
        }
        dotsImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(20)
        }
    }
}

//
//  PlusButton.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/26.
//

import UIKit

final class PlusButton: UIButton {
    struct Const {
        static let size: CGFloat = 32
    }

    override var isHighlighted: Bool {
        didSet {
            plusImageView.tintColor = isHighlighted ? Color.gray06 : Color.gray01
        }
    }

    // MARK: - Views
    private let plusImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = R.image.plus()?.withRenderingMode(.alwaysTemplate)
        $0.tintColor = Color.gray01
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
        addSubview(plusImageView)
    }

    func setupViewConstraints() {
        snp.makeConstraints {
            $0.size.equalTo(Const.size)
        }
        plusImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

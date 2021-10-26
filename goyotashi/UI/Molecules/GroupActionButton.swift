//
//  GroupActionButton.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/26.
//

import UIKit

final class GroupActionButton: UIButton {
    struct Const {
        static let size: CGFloat = 72
    }

    // MARK: - Override Variables
    override var isHighlighted: Bool {
        didSet {
            imageBackgroundView.tintColor = isHighlighted ? Color.gray06.withAlphaComponent(0.3) : Color.gray06
        }
    }

    // MARK: - Views
    private let imageBackgroundView = UIView().then {
        $0.backgroundColor = Color.gray06
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
        addSubview(imageBackgroundView)
    }

    func setupViewConstraints() {
        snp.makeConstraints {
            $0.size.equalTo(Const.size)
        }
        imageBackgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

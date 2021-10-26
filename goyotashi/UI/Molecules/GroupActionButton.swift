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
        static let actionImageSize: CGFloat = 32
    }

    // MARK: - Override Variables
    override var isHighlighted: Bool {
        didSet {
            imageBackgroundView.backgroundColor = isHighlighted ? Color.gray06.withAlphaComponent(0.4) : Color.gray06
            actionImageView.tintColor = isHighlighted ? Color.gray03 : Color.gray01
        }
    }

    // MARK: - Views
    private let imageBackgroundView = UIView().then {
        $0.backgroundColor = Color.gray06
        $0.layer.cornerRadius = 24
        $0.layer.masksToBounds = true
        $0.isUserInteractionEnabled = false
    }

    private let actionImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.tintColor = Color.gray01
        $0.image = R.image.photo_library()?.withRenderingMode(.alwaysTemplate)
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
        imageBackgroundView.addSubview(actionImageView)
    }

    func setupViewConstraints() {
        snp.makeConstraints {
            $0.size.equalTo(Const.size)
        }
        imageBackgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        actionImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(Const.actionImageSize)
        }
    }
}

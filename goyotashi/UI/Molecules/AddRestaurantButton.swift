//
//  AddRestaurantButton.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/26.
//

import UIKit

final class AddRestaurantButton: UIButton {

    struct Const {
        static let imageBackgroundViewSize: CGFloat = 72
        static let actionImageSize: CGFloat = 32
    }

    // MARK: - Override Variables
    override var isHighlighted: Bool {
        didSet {
            overlayView.isHidden = !isHighlighted
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
        $0.image = R.image.plus()?.withRenderingMode(.alwaysTemplate)
    }

    private let actionNameLabel = UILabel().then {
        $0.apply(fontStyle: .medium, size: 11, color: Color.gray01)
        $0.text = "追加する"
    }

    private let overlayView = UIView().then {
        $0.backgroundColor = Color.white.withAlphaComponent(0.8)
        $0.isUserInteractionEnabled = false
        $0.isHidden = true
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
        addSubview(actionNameLabel)
        addSubview(overlayView)
    }

    func setupViewConstraints() {
        imageBackgroundView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.size.equalTo(Const.imageBackgroundViewSize)
        }
        actionImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(Const.actionImageSize)
        }
        actionNameLabel.snp.makeConstraints {
            $0.top.equalTo(imageBackgroundView.snp.bottom).offset(8)
            $0.centerX.bottom.equalToSuperview()
        }
        overlayView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

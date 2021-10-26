//
//  OpenMapButton.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/26.
//

import UIKit

final class OpenMapButton: UIButton {
    enum MapAppType {
        case nativeApp
        case googleMap

        var actionName: String {
            switch self {
            case .nativeApp:
                return "マップで開く"
            case .googleMap:
                return "Google Mapsで開く"
            }
        }
    }

    struct Const {
        static let height: CGFloat = 40
        static let cornerRadius: CGFloat =  8
        static let iconSize: CGFloat = 16
    }

    // MARK: - Override Variables
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

    // MARK: - Initializers
    init(mapAppType: MapAppType) {
        super.init(frame: .zero)

        setupViews()
        setupViewConstraints()
        configure(mapAppType: mapAppType)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Methods
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

    // MARK: - Configure Methods
    private func configure(mapAppType: MapAppType) {
        actionNameLabel.text = mapAppType.actionName
    }
}

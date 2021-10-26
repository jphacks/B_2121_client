//
//  CountableGroupMemberButton.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/26.
//

import UIKit

final class CountableGroupMemberButton: UIButton {

    override var isHighlighted: Bool {
        didSet {
            overlayView.isHidden = !isHighlighted
        }
    }

    // MARK: - Views
    private let memberIconViews: [MemberIconView] = (0 ..< 3).map { _ in
        return MemberIconView().then {
            $0.isUserInteractionEnabled = false
        }
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
        _ = memberIconViews.map { addSubview($0) }
        addSubview(overlayView)
    }

    func setupViewConstraints() {
        memberIconViews[0].snp.makeConstraints {
            $0.top.left.bottom.equalToSuperview()
        }
        memberIconViews[1].snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalTo(memberIconViews[0]).offset(30)
        }
        memberIconViews[2].snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalTo(memberIconViews[1]).offset(30)
            $0.right.lessThanOrEqualToSuperview()
        }
        overlayView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

fileprivate final class MemberIconView: UIView, ViewConstructor {
    struct Const {
        static let size: CGFloat = 46
        static let imageViewSize: CGFloat = 44
    }

    // MARK: - Views

    let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = Const.imageViewSize / 2
        $0.layer.masksToBounds = true
        $0.backgroundColor = Color.gray06
    }

    let countLabel = UILabel().then {
        $0.apply(fontStyle: .medium, size: 15, color: Color.gray01)
        $0.text = "2"
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
        backgroundColor = Color.white
        layer.cornerRadius = Const.size / 2
        layer.masksToBounds = true

        addSubview(imageView)
        addSubview(countLabel)
    }

    func setupViewConstraints() {
        snp.makeConstraints {
            $0.size.equalTo(Const.size)
        }
        imageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(Const.imageViewSize)
        }
        countLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

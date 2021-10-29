//
//  GroupMemberButton.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/26.
//

import UIKit

final class GroupMemberButton: UIButton {

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

    private let memberCountLalbel = UILabel().then {
        $0.apply(fontStyle: .medium, size: 16, color: Color.gray01)
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
        addSubview(memberCountLalbel)
        addSubview(overlayView)
    }

    func setupViewConstraints() {
        memberIconViews[0].snp.makeConstraints {
            $0.top.left.equalToSuperview()
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
        memberCountLalbel.snp.makeConstraints {
            $0.top.equalTo(memberIconViews[0].snp.bottom).offset(8)
            $0.left.bottom.equalToSuperview()
            $0.right.lessThanOrEqualToSuperview()
        }
        overlayView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: Configure Methods
    func configure(imageUrlStrings: [String?], memberCount: Int) {
        let imageUrls: [URL?] = (0 ..< 3).map { index in
            if imageUrlStrings.indices.contains(index) {
                let urlString = imageUrlStrings[index]
                return URL(string: urlString ?? "")
            } else {
                return nil
            }
        }
        _ = imageUrls.enumerated().map {
            if let url = $0.element {
                memberIconViews[$0.offset].isHidden = false
                memberIconViews[$0.offset].imageView.kf.setImage(with: url, placeholder: R.image.dish())
            } else {
                memberIconViews[$0.offset].isHidden = true
            }
        }
        memberCountLalbel.text = "\(memberCount)人のメンバー"
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
    }

    func setupViewConstraints() {
        snp.makeConstraints {
            $0.size.equalTo(Const.size)
        }
        imageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(Const.imageViewSize)
        }
    }
}

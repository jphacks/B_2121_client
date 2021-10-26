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
        }
    }

    // MARK: - Views
    private let memberIconViews: [MemberIconView] = (0 ..< 3).map { _ in
        return MemberIconView()
    }

    private let memberCountLalbel = UILabel().then {
        $0.apply(fontStyle: .medium, size: 16, color: Color.gray01)
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
        _ = memberIconViews.map { addSubview($0) }
        addSubview(memberCountLalbel)
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
            $0.top.equalTo(memberIconViews[0]).offset(8)
            $0.left.bottom.equalToSuperview()
            $0.right.lessThanOrEqualToSuperview()
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
        $0.backgroundColor = Color.gray02
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

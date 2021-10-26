//
//  GroupMemberButton.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/26.
//

import UIKit

final class GroupMemberButton: UIButton {
    struct Const {
        static let width: CGFloat = 120
        static let height: CGFloat = 78
    }

    override var isHighlighted: Bool {
        didSet {
        }
    }

    // MARK: - Views
    private let memberIconView = MemberIconView()

    override init(frame: CGRect) {
        super.init(frame: .zero)

        setupViews()
        setupViewConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        addSubview(memberIconView)
        backgroundColor = Color.gray01
    }

    func setupViewConstraints() {
        snp.makeConstraints {
            $0.width.equalTo(Const.width)
            $0.height.equalTo(Const.height)
        }
        memberIconView.snp.makeConstraints {
            $0.center.equalToSuperview()
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

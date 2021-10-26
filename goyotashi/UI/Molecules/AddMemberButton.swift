//
//  AddMemberButton.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/27.
//

import UIKit

final class AddMemberButton: UIButton {
    struct Const {
        static let size: CGFloat = 44
        static let imageViewSize: CGFloat = 18
    }

    override var isHighlighted: Bool {
        didSet {
        }
    }

    // MARK: - Views
    private let addMemberImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = R.image.person_add()
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
        backgroundColor = Color.gray06
        layer.cornerRadius = Const.size / 2
        layer.masksToBounds = true

        addSubview(addMemberImageView)
    }

    func setupViewConstraints() {
        snp.makeConstraints {
            $0.size.equalTo(Const.size)
        }
        addMemberImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(Const.imageViewSize)
        }
    }
}

//
//  OnboardingNameInputView.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/30.
//

import UIKit

class OnboardingNameInputView: UIView, ViewConstructor {

    let questionLabel = UILabel().then {
        $0.apply(fontStyle: .bold, size: 24)
        $0.numberOfLines = 0
        $0.text = "あなたの名前\nを教えてください"
        $0.textColor = Color.white
    }

    let nameTextField = UITextField().then {
        $0.font = UIFont(name: FontStyle.bold.rawValue, size: 24)
        $0.tintColor = Color.white
        $0.textColor = Color.white
        $0.attributedPlaceholder = NSAttributedString(string: "名前", attributes: [NSAttributedString.Key.foregroundColor: Color.white.withAlphaComponent(0.6)])
        $0.returnKeyType = .done
    }

    let border = UIView().then {
        $0.backgroundColor = Color.white
    }

    let nextButton = UIButton().then {
        $0.titleLabel?.apply(fontStyle: .bold, size: 24)
        $0.setTitle("次へ", for: .normal)
        $0.setTitleColor(Color.white, for: .normal)
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
        addSubview(questionLabel)
        addSubview(nameTextField)
        addSubview(border)
        addSubview(nextButton)
    }

    func setupViewConstraints() {
        questionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.left.equalToSuperview().inset(48)
        }
        nameTextField.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(48)
            $0.bottom.equalTo(border.snp.top).offset(-8)
        }
        border.snp.makeConstraints {
            $0.left.width.equalTo(nameTextField)
            $0.height.equalTo(2)
            $0.centerY.equalToSuperview()
        }
        nextButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(72)
        }
    }
}

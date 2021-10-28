//
//  PlaceholderTextView.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/28.
//

import UIKit

final class PlaceholderTextView: UITextView, ViewConstructor {

    var placeholder: String = "" {
        didSet {
            placeholderLabel.text = placeholder
        }
    }

    // MARK: - Views
    private let placeholderLabel = UILabel().then {
        $0.textColor = Color.gray04
    }

    // MARK: - Initializers
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: .zero, textContainer: textContainer)

        setupViews()
        setupViewConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Methods
    func setupViews() {
        delegate = self
        addSubview(placeholderLabel)
    }

    func setupViewConstraints() {
        placeholderLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
    }
}

extension PlaceholderTextView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = textView.text != ""
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange,
                  replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}

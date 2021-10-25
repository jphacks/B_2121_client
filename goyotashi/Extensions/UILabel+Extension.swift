//
//  UILabel+Extension.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/25.
//

import UIKit

enum FontStyle: String {
    case bold = "NotoSansJP-Bold"
    case medium = "NotoSansJP-Medium"
    case regular = "NotoSansJP-Regular"
}

extension UILabel {

    func apply(fontStyle: FontStyle, size: CGFloat, color: UIColor = Color.gray01) {
        font = UIFont(name: fontStyle.rawValue, size: size)
        textColor = color
    }
}

//
//  UIImageView+Extension.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/30.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImageWithHPGUrl(urlString: String) {
        let updatedUrlString = updateSuffix(urlString: urlString)
        let sources: [Source] = [urlString].compactMap(buildSource(urlString:))
        let optionsInfo = KingfisherOptionsInfoItem.alternativeSources(sources)
        self.kf.setImage(with: URL(string: updatedUrlString), placeholder: R.image.dish(), options: [optionsInfo])
    }

    private func updateSuffix(urlString: String) -> String {
        let prefix = String(urlString.prefix(urlString.count - 7))
        let updatedUrlString = "\(prefix)480.jpg"
        return updatedUrlString
    }

    private func buildSource(urlString: String) -> Source? {
        let url = URL(string: urlString)
        guard let url = url else { return nil }
        let source = Source.network(url)
        return source
    }
}

//
//  DevelopingViewController.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/25.
//

import UIKit
import Then
import SnapKit

final class DevelopingViewController: UIViewController, ViewConstructor {
    private let developingLabel = UILabel().then {
        $0.text = "Developing ViewController"
        $0.apply(fontStyle: .bold, size: 24)
        $0.textAlignment = .center
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupViewConstraints()
    }

    func setupViews() {
        view.addSubview(developingLabel)
    }

    func setupViewConstraints() {
        developingLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

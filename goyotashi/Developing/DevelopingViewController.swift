//
//  DevelopingViewController.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/25.
//

import UIKit
import Then
import SnapKit

final class DevelopingViewController: UIViewController {
    private let developingLabel = UILabel().then {
        $0.text = "Developing ViewController"
        $0.textAlignment = .center
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(developingLabel)
        developingLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

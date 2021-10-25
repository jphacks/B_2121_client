//
//  TabBarController.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/25.
//

import UIKit

class TabBarController: UITabBarController {
    private struct Const {
        static let tabBarTitles: [String] = ["ホーム", "プロフィール"]
        static let tabBarImages: [UIImage] = [#imageLiteral(resourceName: "home_empty"), #imageLiteral(resourceName: "user_empty")]
        static let tabBarSelectedImages: [UIImage] = [#imageLiteral(resourceName: "home_filled"), #imageLiteral(resourceName: "user_filled")]
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.white
        setupViewControllers()
    }

    // MARK: - Setup Methods
    private func setupViewControllers() {
        viewControllers = [
            DevelopingViewController(),
            DevelopingViewController()
        ]

        tabBar.do {
            $0.isTranslucent = false
            $0.tintColor = Color.gray01
            $0.unselectedItemTintColor = Color.gray03
            $0.items?.enumerated().forEach { index, tabBarItem in
                tabBarItem.title = Const.tabBarTitles[index]
                tabBarItem.image = Const.tabBarImages[index]
                tabBarItem.selectedImage = Const.tabBarSelectedImages[index]
                tabBarItem.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
            }
        }
    }
}
//
//  TabBarController.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/25.
//

import UIKit

final class TabBarController: UITabBarController {
    private struct Const {
        static let tabBarTitles: [String] = ["ホーム", "プロフィール"]
        static let tabBarImages: [UIImage?] = [R.image.home_empty(), R.image.user_empty()]
        static let tabBarSelectedImages: [UIImage?] = [R.image.home_filled(), R.image.user_filled()]
    }

    private let provider: ServiceProviderType

    // MARK: - Initializers
    init(provider: ServiceProviderType) {
        self.provider = provider
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.white
        setupViewControllers()

        UINavigationBar.appearance().tintColor = Color.gray01
    }

    // MARK: - Setup Methods
    private func setupViewControllers() {
        viewControllers = [
            UINavigationController(
                rootViewController: HomeViewController().then {
                    $0.reactor = HomeReactor(provider: provider)
                }
            ),
            UINavigationController(
                rootViewController: ProfileViewController().then {
                    $0.reactor = ProfileReactor(provider: provider)
                }
            )
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

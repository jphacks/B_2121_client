//
//  DeviceSize.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/25.
//

import UIKit

struct DeviceSize {
    static var screenBounds: CGRect {
        return UIScreen.main.bounds
    }

    static var screenWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }

    static var screenHeight: CGFloat {
        return UIScreen.main.bounds.size.height
    }

    static var statusBarHeight: CGFloat {
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            return window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            return UIApplication.shared.statusBarFrame.height
        }
    }

    static func navBarHeight(_ navigationController: UINavigationController?) -> CGFloat {
        return navigationController?.navigationBar.frame.size.height ?? 0
    }

    static func tabBarHeight(_ tabBarController: UITabBarController?) -> CGFloat {
        return tabBarController?.tabBar.frame.size.height ?? 0
    }
}

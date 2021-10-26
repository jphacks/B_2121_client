//
//  ProfileViewController.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/26.
//

import UIKit
import ReactorKit
import SegementSlide

final class ProfileViewController: SegementSlideDefaultViewController, View, ViewConstructor {

    // MARK: - Variables
    var disposeBag = DisposeBag()

    // MARK: - Override Variables
    override var titlesInSwitcher: [String] {
        return ["参加", "保存"]
    }

    override var switcherConfig: SegementSlideDefaultSwitcherConfig {
        var config = super.switcherConfig
        if let normalFont = UIFont(name: FontStyle.medium.rawValue, size: 13) {
            config.normalTitleFont = normalFont
        }
        if let selectedFont = UIFont(name: FontStyle.bold.rawValue, size: 13) {
            config.selectedTitleFont = selectedFont
        }
        config.normalTitleColor = Color.gray03
        config.selectedTitleColor = Color.gray01
        config.horizontalMargin = 16
        config.horizontalSpace = 24
        return config
    }

    // MARK: - Views
    private let header = ProfileHeaderView()

    // MARK: - Lify Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        reloadData()
        defaultSelectedIndex = 0
    }

    // MARK: - Setup Methods
    func setupViews() {}

    func setupViewConstraints() {}

    // MARK: - Bind Method
    func bind(reactor: ProfileReactor) {
        header.reactor = reactor

        // Action
        header.plusButton.rx.tap
            .bind { [weak self] _ in
                let viewController = CreateGroupViewController().then {
                    $0.reactor = reactor.createCreateGroupReactor()
                }
                let navController = UINavigationController(rootViewController: viewController).then {
                    $0.modalPresentationStyle = .fullScreen
                }
                self?.present(navController, animated: true, completion: nil)
            }
            .disposed(by: disposeBag)

        // State
    }

    // MARK: - Override Functions
    override func segementSlideContentViewController(at index: Int) -> SegementSlideContentScrollViewDelegate? {
        switch index {
        case 0:
            return ProfileGroupListViewController().then {
                $0.reactor = ProfileGroupListReactor()
            }
        default:
            return ProfileGroupListViewController().then {
                $0.reactor = ProfileGroupListReactor()
            }
        }
    }

    override func segementSlideHeaderView() -> UIView? {
        return header
    }
}

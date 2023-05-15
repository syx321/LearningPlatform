//
//  MainTabBarController.swift
//  LearningPlatform
//
//  Created by 苏易肖 on 2023/3/8.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    var resolver: DIResolvable?
}

extension MainTabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        setupView()
    }
    
    private func setupView() {
        tabBar.backgroundColor = .white
        var viewControllers: [UIViewController] = []
        for item in MainFrameHandler.registeredItem {
            let controller = item.viewControllerInMainTabBarController()
            viewControllers.append(controller)
        }
        self.viewControllers = viewControllers
    }
}

extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if let navController = viewController as? BaseNavigationController,
           let vc = navController.viewControllers[0, true] as? MinePageController {
//            if MainFrameModule.userDidLogIn {
                return true
//            } else {
//                MinePageModule.presentLogInController()
//            }
        } else {
            return true
        }
        return false
    }
}

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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }
    
    private func setupView() {
        tabBar.backgroundColor = .white
        for item in MainFrameHandler.registeredItem {
            let controller = item.viewControllerInMainTabBarController()
            controller.tabBarItem = item.tabBarItem()
            addChild(controller)
        }
    }
}

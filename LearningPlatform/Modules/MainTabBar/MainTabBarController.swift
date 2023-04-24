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

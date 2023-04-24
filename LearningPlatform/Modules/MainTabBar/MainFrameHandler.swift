//
//  MainFrameHandler.swift
//  LearningPlatform
//
//  Created by 苏易肖 on 2023/3/8.
//

import Foundation
import UIKit

protocol MainFrameHandling {
    func viewControllerInMainTabBarController() -> UIViewController
    func tabBarItem() -> UITabBarItem
}

class MainFrameHandler {
    static let shared = MainFrameHandler()
    static var registeredItem: [MainFrameHandling] = []
    static let mainTabBarController = MainTabBarController()
    
    static func createMainTabBarController() {
        guard let delegate = UIApplication.shared.delegate,
              let window = delegate.window else {
            fatalError("MainFrameHandler get nil window")
        }
        window?.rootViewController = mainTabBarController
    }
    
    static func registerMainTabbarItem(item: MainFrameHandling) {
        registeredItem.append(item)
    }
    
    static func switchToTabbar() {
        
    }
}

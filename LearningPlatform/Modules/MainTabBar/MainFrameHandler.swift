//
//  MainFrameHandler.swift
//  LearningPlatform
//
//  Created by 苏易肖 on 2023/3/8.
//

import Foundation
import UIKit

class MainFrameHandler {
    static let shared = MainFrameHandler()
    static let mainTabBarController = MainTabBarController()
    
    static func createMainTabBarController() {
        guard let delegate = UIApplication.shared.delegate,
              let window = delegate.window else {
            fatalError("MainFrameHandler get nil window")
        }
        window?.rootViewController = mainTabBarController
    }
}

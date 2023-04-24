//
//  BaseNavigationController.swift
//  LearningPlatform
//
//  Created by 苏易肖 on 2023/4/24.
//

import Foundation
import UIKit

class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetBarAppearance()
    }
    
    func resetBarAppearance() {
        let navAppearance = UINavigationBarAppearance()
        navAppearance.backgroundColor = .white
        navAppearance.shadowColor = .clear
        navAppearance.backgroundEffect = nil
        navigationBar.standardAppearance.configureWithOpaqueBackground()
        navigationBar.standardAppearance.backgroundImage = nil
        navigationBar.standardAppearance = navAppearance
        navigationBar.scrollEdgeAppearance = navAppearance
    }
    
    func updateBarAppearance() {
        let navAppearance = UINavigationBarAppearance()
        navAppearance.backgroundColor = .clear
        navAppearance.shadowColor = nil
        navAppearance.backgroundEffect = nil
        navigationBar.standardAppearance = navAppearance
        navigationBar.scrollEdgeAppearance = navAppearance
        navigationBar.standardAppearance.configureWithTransparentBackground()
    }
    
}

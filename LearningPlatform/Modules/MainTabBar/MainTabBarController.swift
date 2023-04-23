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
    private var mainPageModuleService: MainPageModuleService?
    private var minePageModuleService: MinePageModuleService?
    
    override func viewDidLoad() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupServices()
        setupView()
    }
    
    private func setupServices() {
        mainPageModuleService = resolver?(MainPageModuleService.self)
        minePageModuleService = resolver?(MinePageModuleService.self)
    }
    
    private func setupView() {
        tabBar.backgroundColor = .white
        guard let mainController = mainPageModuleService?.createMainPageController(),
              let mineController = minePageModuleService?.createMainPageController() else {
            return
        }
        
        mainController.tabBarItem.title = "主页"
        mainController.tabBarItem.image = UIImage(systemName: "house.circle")
        mainController.tabBarItem.selectedImage = UIImage(systemName: "house.circle.fill")
        
        mineController.tabBarItem.title = "我的"
        mineController.tabBarItem.image = UIImage(systemName: "person.circle")
        mineController.tabBarItem.selectedImage = UIImage(systemName: "person.circle.fill")
        
        addChild(mainController)
        addChild(mineController)
    }
    
    
}

extension MainTabBarController {
    
}

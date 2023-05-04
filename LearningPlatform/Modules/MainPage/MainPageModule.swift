//
//  MainPageModule.swift
//  LearningPlatform
//
//  Created by 苏易肖 on 2023/3/9.
//

import Foundation
import UIKit

protocol MainPageModuleService {
    func createMainPageController() -> MainPageController
}

class MainPageModule: MainPageModuleService{
    private var navigationController: UINavigationController?
    private let resolver: DIResolvable?
    private let mainPageController: MainPageController
    init(resolver: DIResolvable?) {
        self.resolver = resolver
        Assembler.shared.registMainPageServices()
        mainPageController = MainPageController(resolver: resolver)
    }
    
    func createMainPageController() -> MainPageController {
        return mainPageController
    }
}

extension MainPageModule: AppSetupManagerModule {
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        MainFrameHandler.registerMainTabbarItem(item: self)
        return true
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        return true
    }
}

extension MainPageModule: MainFrameHandling {
    func viewControllerInMainTabBarController() -> UIViewController {
        let mainController =  createMainPageController()
        let navigationController = BaseNavigationController()
        navigationController.viewControllers = [mainController]
        navigationController.tabBarItem = self.tabBarItem()
        return navigationController
    }
    
    func tabBarItem() -> UITabBarItem {
        UITabBarItem(title: "主页", image: UIImage(systemName: "house.circle"), selectedImage: UIImage(systemName: "house.circle.fill"))
    }
}

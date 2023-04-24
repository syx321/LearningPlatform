//
//  MinePageModule.swift
//  LearningPlatform
//
//  Created by 苏易肖 on 2023/3/9.
//

import Foundation
import UIKit

protocol MinePageModuleService {
    func createMinePageController() -> MinePageController
}

class MinePageModule: MinePageModuleService {
    private let resolver: DIResolvable?
    init(resolver: DIResolvable?) {
        self.resolver = resolver
    }
    
    func createMinePageController() -> MinePageController {
        let vc = MinePageController(resolver: resolver)
        vc.tabBarItem = tabBarItem()
        return vc
    }
    
}

extension MinePageModule: AppSetupManagerModule {
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        MainFrameHandler.registerMainTabbarItem(item: self)
        return true
    }
}

extension MinePageModule: MainFrameHandling {
    func viewControllerInMainTabBarController() -> UIViewController {
        let vc = createMinePageController()
        let navigationController = BaseNavigationController()
        navigationController.viewControllers = [vc]
        navigationController.tabBarItem = self.tabBarItem()
        return navigationController
    }
    
    func tabBarItem() -> UITabBarItem {
        UITabBarItem(title: "我的", image: UIImage(systemName: "person.circle"), selectedImage: UIImage(systemName: "person.circle.fill"))
    }
}

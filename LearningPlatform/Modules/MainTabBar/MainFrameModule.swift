//
//  MainFrameModule.swift
//  LearningPlatform
//
//  Created by 苏易肖 on 2023/3/22.
//

import Foundation
import UIKit

protocol MainFrameModuleService {
    
}

class MainFrameModule: MainFrameModuleService {
    private let tabbarController = MainFrameHandler.mainTabBarController
    
    init(resolver: DIResolvable?) {
        tabbarController.resolver = resolver
    }
    
}

extension MainFrameModule: AppSetupManagerModule {
    /// 即将完成启动
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        return true
    }
    
    /// 已经完成启动
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        MainFrameHandler.createMainTabBarController()
        return true
    }
    
    /// 用户登陆
    func userDidLogin() {
        
    }
    
    /// 用户退出登陆
    func userDidLogout() {
        
    }
}

//
//  AppDelegate.swift
//  LearningPlatform
//
//  Created by 苏易肖 on 2023/3/8.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        /// 注册模块module
        AppSetupManager.shared.registerModule(MainFrameModule())
        AppSetupManager.shared.registerModule(DIModule())
        AppSetupManager.shared.registerModule(MainPageModule())
        AppSetupManager.shared.registerModule(MinePageModule())
        
        return AppSetupManager.shared.application(application, willFinishLaunchingWithOptions: launchOptions)
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        return AppSetupManager.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

}


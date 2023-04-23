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
        /// 注册模块
        Assembler.shared.registCommonService()
        AppSetupManager.shared.registerModule(MainFrameModule(resolver: Assembler.resolver))
        AppSetupManager.shared.registerModule(MainPageModule(resolver: Assembler.resolver))
        AppSetupManager.shared.registerModule(MinePageModule(resolver: Assembler.resolver))
        
        return AppSetupManager.shared.application(application, willFinishLaunchingWithOptions: launchOptions)
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        return AppSetupManager.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

}


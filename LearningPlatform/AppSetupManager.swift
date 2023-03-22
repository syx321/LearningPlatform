//
//  AppSetupManager.swift
//  LearningPlatform
//
//  Created by 苏易肖 on 2023/3/8.
//

import Foundation
import UIKit

protocol AppSetupManagerModule: AnyObject {
    /// 即将完成启动
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool
    /// 已经完成启动
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    /// 用户登陆
    func userDidLogin()
    /// 用户退出登陆
    func userDidLogout()
}

extension AppSetupManagerModule {
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool { return true }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool { return true }
    func userDidLogin() {}
    func userDidLogout() {}
}

class AppSetupManager {
    var registeredModules: [AppSetupManagerModule] = []
    static let shared = AppSetupManager()
    
    
    /// 在AppDelegate willFinishLaunchingWithOptions中调用完成注册模块
    /// - Parameter object: 遵循AppSetupManagerModule的模块
    func registerModule(_ object: (AnyObject & AppSetupManagerModule)) {
        registeredModules.append(object)
    }
    
    
    /// 通知注册模块app即将完成启动
    /// - Parameters:
    ///   - application: UIApplication
    ///   - launchOptions: [UIApplication.LaunchOptionsKey : Any]?
    /// - Returns: 模块是否全部注册成功
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        var result = true
        for module in registeredModules {
            result = module.application(application, willFinishLaunchingWithOptions: launchOptions)
            if !result {
                return false
            }
        }
        return true
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        var result = true
        for module in registeredModules {
            result = module.application(application, didFinishLaunchingWithOptions: launchOptions)
            if !result {
                return false
            }
        }
        return true
    }
    
    func userDidLogin() {
        registeredModules.forEach { $0.userDidLogin() }
    }
    
    func userDidLogout() {
        registeredModules.forEach { $0.userDidLogout() }
    }
    
}

//
//  UIWindow+Extension.swift
//  LearningPlatform
//
//  Created by 苏易肖 on 2023/4/23.
//

import Foundation
import UIKit

extension UIWindow {
    func visiableViewController() -> UIViewController? {
        return UIWindow.visiableViewControllerFrom(vc: rootViewController)
    }
    
    static func visiableViewControllerFrom(vc: UIViewController?) -> UIViewController? {
        if let vc = vc?.presentedViewController {
            return visiableViewControllerFrom(vc: vc)
        } else if let vc = vc as? UINavigationController {
            return visiableViewControllerFrom(vc: vc.visibleViewController)
        } else if let vc = vc as? UITabBarController {
            return visiableViewControllerFrom(vc: vc.selectedViewController)
        } else {
            return vc
        }
    }
}

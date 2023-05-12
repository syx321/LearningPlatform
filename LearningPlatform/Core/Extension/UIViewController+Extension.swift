//
//  UIViewController+Extension.swift
//  LearningPlatform
//
//  Created by 苏易肖 on 2023/4/23.
//

import Foundation
import UIKit

extension UIViewController {
    static func topViewController() -> UIViewController? {
        return UIApplication.shared.keyWindow?.visiableViewController()
    }
    
    static func topViewControllerInRootWindow() -> UIViewController? {
        return topViewControllerInWindow(window: UIApplication.shared.keyWindow)
    }
    
    static func topViewControllerInWindow(window: UIWindow?) -> UIViewController? {
        return UIWindow.visiableViewControllerFrom(vc: window?.rootViewController)
    }
    
    func isViewVisiable() -> Bool {
        return isViewLoaded && view.window != nil && self.presentationController == nil
    }
    
    func pushFromTopViewController(completion:(() -> Void)? = nil) {
        if let navigationController = UIViewController.topViewController()?.navigationController {
            navigationController.customPushViewController(viewController: self, animated: true) {
                completion?()
            }
        }
    }
    
    func popController(animated: Bool, completion:(() -> Void)? = nil) {
        navigationController?.customPopViewController(animated: animated, completion: {
            completion?()
        })
    }
}

extension UINavigationController {
    public func customPushViewController(viewController: UIViewController,
                                                animated: Bool,
                                                completion: (() -> Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }
    
    public func customPopViewController(animated:Bool,
                                               completion:(() -> Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popViewController(animated: animated)
        CATransaction.commit()
    }
}

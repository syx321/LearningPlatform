//
//  BaseViewController.swift
//  LearningPlatform
//
//  Created by 苏易肖 on 2023/4/23.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    public var perfersNavigationBarHidden: Bool {
        return false
    }
    
    public var perferNavigationBarTranslucent: Bool {
        return false
    }
    
    public var perferToolBarHidden: Bool {
        return true
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        modalPresentationCapturesStatusBarAppearance = true
        modalPresentationStyle = .fullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var backButton: UIButton {
        let v = UIButton()
        v.imageView?.image = UIImage(systemName: "chevron.backward")
        v.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        return v
    }
}

extension BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        edgesForExtendedLayout = .all
        extendedLayoutIncludesOpaqueBars = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let nav = self.navigationController,
           self.parent == nav {
            self.navigationController?.navigationBar.isHidden = perfersNavigationBarHidden
            self.navigationController?.setNavigationBarHidden(perfersNavigationBarHidden, animated: animated)
            self.navigationController?.navigationBar.isTranslucent = perferNavigationBarTranslucent
            self.navigationController?.setToolbarHidden(true, animated: animated)
            if let _ = presentingViewController,
               navigationController?.viewControllers.count == 1 {
//                self.navigationItem.backBarButtonItem?.isHidden = false
            } else {
//                self.navigationItem.backBarButtonItem?.isHidden = true
            }
        }
    }
    
    override var title: String? {
        didSet {
            self.navigationItem.title = title
        }
    }
}

extension BaseViewController {
    // TODO: 增加返回按钮点击事件
    @objc func backAction() {
        
    }
}

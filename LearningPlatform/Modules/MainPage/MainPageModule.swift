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
    private let resolver: DIResolvable?
    init(resolver: DIResolvable?) {
        self.resolver = resolver
    }
    
    func createMainPageController() -> MainPageController {
        MainPageController(resolver: resolver)
    }
}

extension MainPageModule: AppSetupManagerModule {
    
}

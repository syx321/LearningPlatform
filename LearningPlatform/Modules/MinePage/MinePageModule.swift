//
//  MinePageModule.swift
//  LearningPlatform
//
//  Created by 苏易肖 on 2023/3/9.
//

import Foundation
import UIKit

protocol MinePageModuleService {
    func createMainPageController() -> MinePageController
}

class MinePageModule: MinePageModuleService {
    private let resolver: DIResolvable?
    init(resolver: DIResolvable?) {
        self.resolver = resolver
    }
    
    func createMainPageController() -> MinePageController {
        MinePageController(resolver: resolver)
    }
    
}

extension MinePageModule: AppSetupManagerModule {
    
}

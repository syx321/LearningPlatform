//
//  Assembler.swift
//  LearningPlatform
//
//  Created by 苏易肖 on 2023/3/22.
//

import Foundation

/// 组装依赖中心在此向container注入所有依赖
final class Assembler {
    static let shared = Assembler()
    static var resolver: DIResolvable? {
        return shared.container(DIResolvable.self)
    }
    
    private let container = DIContainer(parent: nil)
}

extension Assembler: LiveAssembling {
    /// 在模块启动时调用
    func registCommonService() {
        container.register(DIResolvable.self, scopeType: .weak) { _ in
            return self.container
        }
        container.register(MainFrameModuleService.self, scopeType: .weak) {
            return MainFrameModule(resolver: $0)
        }
        container.register(MainPageModuleService.self, scopeType: .weak) {
            return MainPageModule(resolver: $0)
        }
        container.register(MinePageModuleService.self, scopeType: .weak) {
            return MinePageModule(resolver: $0)
        }
    }
    
    /// 主页注册
    func registMainPageServices() {
        container.register(VideoPlayerService.self, scopeType: .weak) {
            return VideoPlayerPlugin(resolver: $0)
        }
        container.register(UserFeedService.self, scopeType: .weak) {
            return UserFeedPlugin(resolver: $0)
        }
    }
    
    /// 我的页面注册
    func registMinePageServices() {
        
    }
}

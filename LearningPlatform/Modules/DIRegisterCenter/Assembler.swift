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
    private weak var activeRoomResolver: DIResolvable? // 当前活跃房间的解析器
}

extension Assembler: LiveAssembling {
    /// 在模块启动时调用
    func registCommonService() {
        
    }
    
}

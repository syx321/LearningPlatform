//
//  UserFeedPlugin.swift
//  LearningPlatform
//
//  Created by 苏易肖 on 2023/5/11.
//

import Foundation

import Foundation
import UIKit

protocol UserFeedService {
    func showUserFeedVC(model: VideoPlayerModel)
}

// MARK: - VideoPlayerService
final class UserFeedPlugin: UserFeedService {
    private let resolver: DIResolvable?
    
    init(resolver: DIResolvable?) {
        self.resolver = resolver
    }
    
    func showUserFeedVC(model: VideoPlayerModel) {
        let vc = UserFeedVC(resolver: resolver, model: model)
        vc.pushFromTopViewController()
    }
}

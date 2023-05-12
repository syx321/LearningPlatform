//
//  VideoPlayerPlugin.swift
//  LearningPlatform
//
//  Created by 苏易肖 on 2023/5/5.
//

import Foundation
import UIKit

protocol VideoPlayerService {
    func showVideoPlayerVC(model: VideoPlayerModel)
}

// MARK: - VideoPlayerService
final class VideoPlayerPlugin: VideoPlayerService {
    private let resolver: DIResolvable?
    
    init(resolver: DIResolvable?) {
        self.resolver = resolver
    }
    
    func showVideoPlayerVC(model: VideoPlayerModel) {
        let vc = VideoPlayerVC(resolver: resolver, model: model)
        vc.pushFromTopViewController()
    }
}

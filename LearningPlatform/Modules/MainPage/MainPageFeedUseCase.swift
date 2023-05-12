//
//  MainPageFeedUseCase.swift
//  LearningPlatform
//
//  Created by 苏易肖 on 2023/4/25.
//

import Foundation
import Alamofire

protocol MainPageFeedUseCaseDelegate: AnyObject {
    func didFetchFeedModels(models: [MainPageFeedCellModel]?)
}

final class MainPageFeedUseCase {
    weak var delegate: MainPageFeedUseCaseDelegate?
    private weak var resolver: DIResolvable?
    private let videoPlayerService: VideoPlayerService?
    
    init(resolver: DIResolvable?) {
        self.resolver = resolver
        videoPlayerService = resolver?(VideoPlayerService.self)
    }
    
    let mockModels = [
        MainPageFeedCellModel(id: "1", avatarUrl: "https://auto.tancdn.com/v1/raw/961614f8-1e7a-4494-8970-78c48cba3a390203.png", name: "someName", desc: "desc", videoUrl: ""),
        MainPageFeedCellModel(id: "1", avatarUrl: "https://auto.tancdn.com/v1/raw/961614f8-1e7a-4494-8970-78c48cba3a390203.png", name: "someName", desc: "desc", videoUrl: ""),
        MainPageFeedCellModel(id: "1", avatarUrl: "https://auto.tancdn.com/v1/raw/961614f8-1e7a-4494-8970-78c48cba3a390203.png", name: "someName", desc: "desc", videoUrl: ""),
        MainPageFeedCellModel(id: "1", avatarUrl: "https://auto.tancdn.com/v1/raw/961614f8-1e7a-4494-8970-78c48cba3a390203.png", name: "someName", desc: "desc", videoUrl: ""),
        MainPageFeedCellModel(id: "1", avatarUrl: "https://auto.tancdn.com/v1/raw/961614f8-1e7a-4494-8970-78c48cba3a390203.png", name: "someName", desc: "desc", videoUrl: ""),
        MainPageFeedCellModel(id: "1", avatarUrl: "https://auto.tancdn.com/v1/raw/961614f8-1e7a-4494-8970-78c48cba3a390203.png", name: "someName", desc: "desc", videoUrl: ""),
        MainPageFeedCellModel(id: "1", avatarUrl: "https://auto.tancdn.com/v1/raw/961614f8-1e7a-4494-8970-78c48cba3a390203.png", name: "someName", desc: "desc", videoUrl: ""),
        MainPageFeedCellModel(id: "1", avatarUrl: "https://auto.tancdn.com/v1/raw/961614f8-1e7a-4494-8970-78c48cba3a390203.png", name: "someName", desc: "desc", videoUrl: ""),
        MainPageFeedCellModel(id: "1", avatarUrl: "https://auto.tancdn.com/v1/raw/961614f8-1e7a-4494-8970-78c48cba3a390203.png", name: "someName", desc: "desc", videoUrl: ""),
    ]
    
//    let mockPlayerModel = VideoPlayerModel(ownerId: "1", videoUrlString: "http://devimages.apple.com.edgekey.net/streaming/examples/bipbop_16x9/gear5/prog_index.m3u8")
    let mockPlayerModel = VideoPlayerModel(ownerId: "1", ownerAvatarUrlStr: "https://auto.tancdn.com/v1/raw/961614f8-1e7a-4494-8970-78c48cba3a390203.png", ownerName: "名字", title: "这是一个标题", videoUrlString: "http://devimages.apple.com.edgekey.net/streaming/examples/bipbop_16x9/gear5/prog_index.m3u8")
    
    
    func fetchFeedData() {
        delegate?.didFetchFeedModels(models: mockModels)
    }
    
    func gotoPlayerPage(id: String?) {
        guard let id = id else { return }
        videoPlayerService?.showVideoPlayerVC(model: mockPlayerModel)
    }
    
    func gotoUserPage(id: String?) {
        guard let id = id else { return }
        
    }
}

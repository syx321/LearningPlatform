//
//  MainPageFeedUseCase.swift
//  LearningPlatform
//
//  Created by 苏易肖 on 2023/4/25.
//

import Foundation

protocol MainPageFeedUseCaseDelegate: AnyObject {
    func didFetchFeedModels(models: [MainPageFeedCellModel]?)
}

final class MainPageFeedUseCase {
    weak var delegate: MainPageFeedUseCaseDelegate?
    
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
    
    func fetchFeedData() {
        delegate?.didFetchFeedModels(models: mockModels)
    }
}

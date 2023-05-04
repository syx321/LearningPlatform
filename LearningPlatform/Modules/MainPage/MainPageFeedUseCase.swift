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
    
    func fetchFeedData() {
        delegate?.didFetchFeedModels(models: [])
    }
}

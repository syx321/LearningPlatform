//
//  MainPageFeedCellModel.swift
//  LearningPlatform
//
//  Created by 苏易肖 on 2023/4/24.
//

import Foundation

struct MainPageFeedCellModel: Decodable {
    let id: String?
    let avatarUrl: String?
    let name: String?
    let desc: String?
    let videoUrl: String?
}

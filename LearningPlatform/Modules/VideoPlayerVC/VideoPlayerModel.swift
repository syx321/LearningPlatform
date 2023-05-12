//
//  MainPageFeedDetailModel.swift
//  LearningPlatform
//
//  Created by 苏易肖 on 2023/5/5.
//

import Foundation

struct VideoPlayerModel: Decodable {
    let ownerId: String?
    let ownerAvatarUrlStr: String?
    let ownerName: String?
    let title: String?
    let videoUrlString: String?
}

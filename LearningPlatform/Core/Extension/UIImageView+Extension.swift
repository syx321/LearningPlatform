//
//  UIImageView+Extension.swift
//  LearningPlatform
//
//  Created by 苏易肖 on 2023/5/1.
//

import Foundation
import SDWebImage

extension UIImageView {
    func imageUrl(_ imageUrl: URL?) {
        self.sd_internalSetImage(with: imageUrl,
                                 placeholderImage: nil,
                                 context: nil,
                                 setImageBlock: nil,
                                 progress: nil)
    }
}

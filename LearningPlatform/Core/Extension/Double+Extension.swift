//
//  Double+Extension.swift
//  LearningPlatform
//
//  Created by 苏易肖 on 2023/5/10.
//

import Foundation

extension Double {
    @inlinable var int: Int { Int(self) }
    @inlinable var uInt: UInt { UInt(self) }
    @inlinable var float: Float { Float(self) }
    @inlinable var cgFloat: CGFloat { CGFloat(self) }
}

//
//  Float+Extension.swift
//  LearningPlatform
//
//  Created by 苏易肖 on 2023/3/8.
//

import Foundation

public extension Float {
    @inlinable var int: Int { Int(self) }
    @inlinable var uInt: UInt { UInt(self) }
    @inlinable var double: Double { Double(self) }
    @inlinable var cgFloat: CGFloat { CGFloat(self) }
}

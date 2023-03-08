//
//  Int+Extension.swift
//  LearningPlatform
//
//  Created by 苏易肖 on 2023/3/8.
//

import Foundation

extension Int {
    
    /// 整数值是否超出了数组边界，作用与 withinBounds 相反
    /// - Parameter array: 要判定边界的数组
    /// - Returns: 如果超出边界，返回 true; 否则，返回 false
    @inlinable public func isBeyondBounds(of array: Array<Any>) -> Bool {
        !((0..<array.count) ~= self)
    }
    
    /// 整数值是否在数组边界内
    /// - Parameter array: 要判定边界的数组
    /// - Returns: 如果在边界内，返回 true；否则，返回 false
    @inlinable public func withinBounds(of array: Array<Any>) -> Bool {
        (0..<array.count) ~= self
    }
}

extension Int {
    
    /// 执行某个闭包该整数值的次数
    /// - Parameter function: 要执行的闭包
    @inlinable public func times(function: (() -> Void)) {
        (0..<self).forEach { index in function() }
    }
    
    func times(indexFunction: ((Int) -> Void)) {
        (0..<self).forEach { index in
            indexFunction(index)
        }
    }
}

extension Int {
    
    /// 是否为偶数
    @inlinable public var isEven: Bool { self & 0x01 == 0 }
    
    /// 是否为奇数
    @inlinable public var isOdd: Bool { self & 0x01 == 1 }
    
    /// 是否为正整数
    @inlinable public var isPositive: Bool { self > 0 }
    
    /// 是否为负整数
    @inlinable public var isNegative: Bool { self < 0 }
}

extension Int {
    @inlinable public var uInt: UInt { UInt(self) }
    @inlinable public var double: Double { Double(self) }
    @inlinable public var float: Float { Float(self) }
    @inlinable public var cgFloat: CGFloat { CGFloat(self) }
}

extension UInt {
    @inlinable public var int: Int { Int(self) }
    @inlinable public var double: Double { Double(self) }
    @inlinable public var float: Float { Float(self) }
    @inlinable public var cgFloat: CGFloat { CGFloat(self) }
    
    /// 整数值是否超出了数组边界，作用与 withinBounds 相反
    /// - Parameter array: 要判定边界的数组
    /// - Returns: 如果超出边界，返回 true; 否则，返回 false
    @inlinable public func isBeyondBounds(of array: Array<Any>) -> Bool {
        !((0..<array.count) ~= self.int)
    }
    
    /// 整数值是否在数组边界内
    /// - Parameter array: 要判定边界的数组
    /// - Returns: 如果在边界内，返回 true；否则，返回 false
    @inlinable public func withinBounds(of array: Array<Any>) -> Bool {
        (0..<array.count) ~= self.int
    }
}

extension UInt64 {
    @inlinable public var int: Int { Int(self) }
    @inlinable public var double: Double { Double(self) }
    @inlinable public var cgFloat: CGFloat { CGFloat(self) }
}

extension Int64 {
    @inlinable public var int: Int { Int(self) }
    @inlinable public var double: Double { Double(self) }
    @inlinable public var cgFloat: CGFloat { CGFloat(self) }
}

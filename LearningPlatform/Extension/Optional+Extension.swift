//
//  Optional+Extension.swift
//  LearningPlatform
//
//  Created by 苏易肖 on 2023/3/8.
//

import Foundation

public protocol AnyOptional {
    var isNil: Bool { get }
}

extension Optional: AnyOptional {
    @inlinable public var isNil: Bool {
        return self == nil
    }
}

extension Optional where Wrapped: Collection {
    @inlinable public var isNilOrEmpty: Bool {
        return self?.isEmpty ?? true
    }
}

extension Optional where Wrapped == String {
    @inlinable public var nonNil: String {
        return self ?? ""
    }
    
    @inlinable public var isNilOrLengthEqualZero: Bool {
        let str = self ?? ""
        return str.isEmpty
    }
}

extension Optional where Wrapped == UInt {
    var nilEqualZero: CGFloat {
        guard let self = self else { return 0 }
        return CGFloat(self)
    }
}

extension Optional where Wrapped == Int {
    var nilEqualZero: CGFloat {
        guard let self = self else { return 0 }
        return CGFloat(self)
    }
}

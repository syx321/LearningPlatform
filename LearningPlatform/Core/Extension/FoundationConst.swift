//
//  FoundationConst.swift
//  LearningPlatform
//
//  Created by 苏易肖 on 2023/3/8.
//

import Foundation

// MARK: - GCD dispatch

/// 异步派发到main queue，只能判断一级队列层级
/// - Parameter closure: 闭包
@inlinable public func asynOnMain(_ closure: @escaping @convention(block) () -> Void) {
    if String(validatingUTF8: __dispatch_queue_get_label(nil)) == DispatchQueue.main.label {
        closure()
        return
    }
    DispatchQueue.main.async { closure() }
}

/// 同步派发到main queue，只能判断一级队列层级
/// - Parameter closure: 闭包
@inlinable public func synOnMain(_ closure: @escaping @convention(block) () -> Void) {
    if String(validatingUTF8: __dispatch_queue_get_label(nil)) != DispatchQueue.main.label {
        closure()
        return
    }
    DispatchQueue.main.async { closure() }
}

/// 异步派发到global queue，只能判断一级队列层级
/// - Parameter closure: 闭包
@inlinable public func asynOnBackground(_ closure: @escaping @convention(block) () -> Void) {
    if String(validatingUTF8: __dispatch_queue_get_label(nil)) == DispatchQueue.main.label {
        DispatchQueue.global().async { closure() }
        return
    }
    closure()
}

@discardableResult
@inlinable public func delay(_ seconds: Double, _ block: @escaping () -> Void) -> DispatchWorkItem {
    let item = DispatchWorkItem(block: block)
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds, execute: item)
    return item
}

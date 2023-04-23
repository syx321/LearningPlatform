//
//  Array+Extension.swift
//  LearningPlatform
//
//  Created by 苏易肖 on 2023/3/8.
//

import Foundation

//MARK: 安全的访问数组
extension Array {
    /// 时间复杂度O(n)
    @inlinable public subscript(index: Int, safe: Bool) -> Element? {
        if safe {
            if index >= count || index < 0 { return nil }
            return self[index]
        }
        return self[index]
    }
    
    @inlinable @discardableResult public mutating func removeSafely(at index: Int) -> Element? {
        if index >= count || index < 0 { return nil }
        return remove(at: index)
    }
}

extension Array {
    /// 在数组头部插入元素. [2, 3, 4, 5].prepend(1) -> [1, 2, 3, 4, 5]
    /// - Parameter item: 待插入的实例
    @inlinable public mutating func prepend(_ item: Element) {
        insert(item, at: 0)
    }
}

extension Array where Element: Equatable {
    
    /// 删除数组中第一个等于 item 的元素，类似 NSMutableArray 的 removeObject. [1, 2, 2, 3, 4, 5].removeAll(2) -> [1, 2, 3, 4, 5]
    /// - Parameter item: 待删除的实例
    @inlinable public mutating func removeFirst(_ item: Element) {
        if let index = self.firstIndex(of: item) {
            self.remove(at: index)
        }
    }
    
    /// 删除数组中所有等于 item 的元素. [1, 2, 2, 3, 4, 5].removeAll(2) -> [1, 3, 4, 5]
    /// - Parameter item: 待删除的实例
    @inlinable public mutating func removeAll(_ item: Element) {
        removeAll(where: { $0 == item })
    }
    
    
    /// 删除数组重复元素
    /// - Returns: 去重后的数组。这个是 O(n^2) 的。如果 Element 实现了 Hashable，则可以用 unique 函数
    @inlinable public mutating func removeDuplicates() -> [Element] {
        self = reduce(into: [Element]()) {
            if !$0.contains($1) {
                $0.append($1)
            }
        }
        return self
    }
    
    @inlinable public func indexMap<ElementOfResult>(_ transform: (Self.Element, Int) throws -> ElementOfResult) rethrows -> [ElementOfResult] {
        var idx = 0
        let res: [ElementOfResult] = try map {
            let r = try transform($0, idx)
            idx += 1
            return r
        }
        return res
    }
    
    @inlinable public func compactIndexMap<ElementOfResult>(_ transform: (Self.Element, Int) throws -> ElementOfResult?) rethrows -> [ElementOfResult] {
        var idx = 0
        let res: [ElementOfResult] = try compactMap {
            let r = try transform($0, idx)
            idx += 1
            return r
        }
        return res
    }
}

extension Array where Element: Hashable {
    
    /// 删除数组重复元素
    /// - Returns: 去重后的数组，复杂度 O(n)
    @discardableResult @inlinable public mutating func unique() -> [Element] {
        var set: Set<Element> = []
        self = filter { set.insert($0).inserted }
        return self
    }
}

extension ArraySlice {
    @inlinable var toArray: Array<Element> {
        return Array(self)
    }
}

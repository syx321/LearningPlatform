//
//  KVStorage.swift
//  LearningPlatform
//
//  Created by 苏易肖 on 2023/3/8.
//

import Foundation

public protocol UnderlyingStorable {
    /// will search the receiver's search list for a default with the key 'defaultName' and return it. If another process has changed defaults in the search list, NSUserDefaults will automatically update to the latest values. If the key in question has been marked as ubiquitous via a Defaults Configuration File, the latest value may not be immediately available, and the registered value will be returned instead
    /// - Parameter defaultName: result
    func object(forKey defaultName: String) -> Any?
    
    /// -setObject:forKey: immediately stores a value (or removes the value if nil is passed as the value) for the provided key in the search list entry for the receiver's suite name in the current user and any host, then asynchronously stores the value persistently, where it is made available to other processes.
    /// - Parameters:
    ///   - value: new value
    ///   - defaultName: key name
    func set(_ value: Any?, forKey defaultName: String)
}

extension UserDefaults: UnderlyingStorable {
}

@propertyWrapper
public struct KVStorage<T> {
    public typealias Getter<T> = (_ underlying: UnderlyingStorable, _ key: String, _ defaultValue: T) -> T
    public typealias Setter<T> = (_ underlying: UnderlyingStorable, _ key: String, _ defaultValue: T, _ newValue: T, _ oldValue: T) -> Void
    
    /// 标识一个对象的key, 可根据实际需要通过`projectedValue`动态修改
    private var key: String
    /// 标识一个对象的key的后缀，比如拼接uid或者其他动态内容 以实现跟随用户或者全局唯一的key
    public var affix: () -> String = { "" }
    public let defaultValue: T
    
    public let underlying = UserDefaults.standard
    
    /// 外部自定义的get方法, nil时走默认的get逻辑
    public var getter: Getter<T>? = nil
    
    /// 外部自定义的set方法，nil时走默认的set逻辑
    public var setter: Setter<T>? = nil
    
    public init(key: String, defaultValue: T, affix: @autoclosure @escaping () -> String, getter: Getter<T>?, setter: Setter<T>?) {
        self.key = key
        self.defaultValue = defaultValue
        self.affix = affix
        self.getter = getter
        self.setter = setter
    }
    
    public var wrappedValue: T {
        get {
            if let getter = getter {
                let value = getter(underlying, fullKey(), defaultValue)
                return value
            }
            return underlying.object(forKey: fullKey()) as? T ?? defaultValue
        }
        set {
            if let setter = setter {
                setter(underlying, fullKey(), defaultValue, newValue, wrappedValue)
                return
            }
            if let value = newValue as? AnyOptional, value.isNil {
                underlying.removeObject(forKey: fullKey())
            } else {
                underlying.set(newValue, forKey: fullKey())
            }
        }
    }
    
    public var projectedValue: Self {
        get { self }
        set { self = newValue }
    }
    
    private func fullKey() -> String {
        let fullKey = key + affix()
        return fullKey
    }
}

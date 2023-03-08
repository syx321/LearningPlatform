//
//  Date+Extension.swift
//  LearningPlatform
//
//  Created by 苏易肖 on 2023/3/8.
//

import Foundation

extension Date {
    /// 用于持久化的时间，debug用系统时间 方便qa测试，release用服务器时间 防止线上用户自己改系统时间出现bug
    /// - Returns: 当前的持久化时间
    @inlinable static func persistenceDate() -> Date {
        return Date()
    }
}

public extension Date {
    @inlinable var nsdate: NSDate {
        return self as NSDate
    }
    
    @inlinable var calendar: Calendar {
        return Calendar.current
    }
    
    @inlinable var year: Int {
        return calendar.component(.year, from: self)
    }
    
    @inlinable var month: Int {
        return calendar.component(.month, from: self)
    }
    
    @inlinable var day: Int {
        return calendar.component(.day, from: self)
    }
    
    @inlinable var hour: Int {
        return calendar.component(.hour, from: self)
    }
    
    @inlinable var minute: Int {
        return calendar.component(.minute, from: self)
    }
    
    @inlinable var second: Int {
        return calendar.component(.second, from: self)
    }
}

public extension Date {
    
    @inlinable var isInToday: Bool {
        return calendar.isDateInToday(self)
    }
    
    @inlinable var isInYesterday: Bool {
        return calendar.isDateInYesterday(self)
    }
    
    @inlinable var isInTomorrow: Bool {
        return calendar.isDateInTomorrow(self)
    }
    
    @inlinable var isInFuture: Bool {
        return self > Date.persistenceDate()
    }
    
    @inlinable var isInPast: Bool {
        return self < Date.persistenceDate()
    }
    
    @inlinable var tomorrow: Date {
        return calendar.date(byAdding: .day, value: 1, to: self) ?? Date()
    }
    
    @inlinable var yesterday: Date {
        return calendar.date(byAdding: .day, value: -1, to: self) ?? Date()
    }
}

public extension NSDate {
    @objc func days(since date: Date) -> Int {
        let days = (self as Date).days(since: date)
        return days
    }
}

public extension Date {
    func isTheSameDay(with date: Date) -> Bool {
        let res = NSCalendar.current.isDate(self, inSameDayAs: date)
        return res
    }
    
    /// 到指定日期的天数 - 准确度高
    /// - Parameter date: 起始日期
    /// - Returns: self - sinceDate 的天数
    func days(since date: Date) -> Int {
        let calendar = NSCalendar.current
        let fromDate = calendar.startOfDay(for: date)
        let toDate = calendar.startOfDay(for: self)
        let difference = calendar.dateComponents([.day], from: fromDate, to: toDate)
        let days = abs(difference.day ?? 0)
        return days
    }
    
    /** 距离date的天数 - 准确度不高
     * 基于 上述 daysSinceDate 优化
     * 精确度没有 上述 daysSinceDate 高，可能存在1天的误差（主要是没有做时区统一而产生的），
     * 绝大部份需求对于这种天数间隔要求不是很强，所以推荐这种方法
     * 在大部分需求中对 两个时间之间的 间隔天数，一般不会要求很精准
     * 可能存在1天的误差
     */
    func days(sinceDateLowAccuracy date: Date) -> Int {
        let ti = Int(fabs(timeIntervalSince(date)))
        let day = ti / 86400
        return day
    }
    
    /// 增加某段时间间隔到指定日期
    /// - Parameters:
    ///   - component: 时间单位
    ///   - value: 增加的间隔值
    /// - Returns: 增加后的日期
    /// let date = Date() // "Jan 12, 2017, 7:07 PM"
    /// let date2 = date.adding(.minute, value: -10) // "Jan 12, 2017, 6:57 PM"
    /// let date3 = date.adding(.day, value: 4) // "Jan 16, 2017, 7:07 PM"
    /// let date4 = date.adding(.month, value: 2) // "Mar 12, 2017, 7:07 PM"
    /// let date5 = date.adding(.year, value: 13) // "Jan 12, 2030, 7:07 PM"
    func adding(_ component: Calendar.Component, value: Int) -> Date {
        return calendar.date(byAdding: component, value: value, to: self)!
    }
    
    /// 作用同 adding(_ , value:)，只是改为了 mutating 版本
    /// var date = Date() // "Jan 12, 2017, 7:07 PM"
    /// date.add(.minute, value: -10) // "Jan 12, 2017, 6:57 PM"
    /// date.add(.day, value: 4) // "Jan 16, 2017, 7:07 PM"
    /// date.add(.month, value: 2) // "Mar 12, 2017, 7:07 PM"
    /// date.add(.year, value: 13) // "Jan 12, 2030, 7:07 PM"
    mutating func add(_ component: Calendar.Component, value: Int) {
        if let date = calendar.date(byAdding: component, value: value, to: self) {
            self = date
        }
    }
    
    /// 日期的开始时间。
    /// 以天为单位的话， 2021.7.21 18:27 的 beginning 是 2021.7.21 0:00。以小时为单位，则是 2021.7.21 18:00。
    ///
    ///     let date = Date() // "Jan 12, 2017, 7:14 PM"
    ///     let date2 = date.start(of: .hour) // "Jan 12, 2017, 7:00 PM"
    ///     let date3 = date.start(of: .month) // "Jan 1, 2017, 12:00 AM"
    ///     let date4 = date.start(of: .year) // "Jan 1, 2017, 12:00 AM"
    ///
    /// - Parameter component: calendar component to get date at the beginning of.
    /// - Returns: date at the beginning of calendar component (if applicable).
    func start(of component: Calendar.Component) -> Date? {
        if component == .day {
            return calendar.startOfDay(for: self)
        }
        
        var components: Set<Calendar.Component> {
            switch component {
            case .second:
                return [.year, .month, .day, .hour, .minute, .second]
                
            case .minute:
                return [.year, .month, .day, .hour, .minute]
                
            case .hour:
                return [.year, .month, .day, .hour]
                
            case .weekOfYear, .weekOfMonth:
                return [.yearForWeekOfYear, .weekOfYear]
                
            case .month:
                return [.year, .month]
                
            case .year:
                return [.year]
                
            default:
                return []
            }
        }
        
        guard !components.isEmpty else { return nil }
        return calendar.date(from: calendar.dateComponents(components, from: self))
    }
    
    /// 以一天的开始作为新的日期
    @inlinable var startOfDay: Date {
        return calendar.startOfDay(for: self)
    }
    
    /// 以后一天的开始作为新的日期
    @inlinable var startOfNextDay: Date {
        return calendar.startOfDay(for: self.tomorrow)
    }
}

public extension Date {
    @inlinable var millisecondTimestamp: Int {
        return Int(timeIntervalSince1970 * 1000)
    }
}

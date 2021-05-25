//
//  DateExtensions.swift
//  Core
//
//  Created by Lucas Marques Bigh (P) on 09/04/21.
//

import Foundation

extension Date {
    
    func getDaysInMonth() -> Int {
        let calendar = Calendar.current
        let dateComponents = DateComponents(year: calendar.component(.year, from: self), month: calendar.component(.month, from: self))
        let date = calendar.date(from: dateComponents)!
        
        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count
        
        return numDays
    }
    
    func component(_ component: Calendar.Component) -> Int {
        return Calendar.current.component(component, from: self)
    }
    
    var firstWeekDay: Int {
        let newDate = self.setting(1, toComponent: .day)
        return newDate.component(.weekday)
    }
    
    func isToday(day: Int) -> Bool {
        let isToday = Date().component(.day) == day
        
        return isToday
    }
    
    var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
    
    func adding(_ value: Int, toComponent component: Calendar.Component) -> Date {
        return Calendar.current.date(byAdding: component, value: value, to: self) ?? self
    }
    
    func setting(_ value: Int, toComponent component: Calendar.Component) -> Date {
        let calendar = Calendar.current
        var dateComponents = calendar.dateComponents([.year, .day, .month, .hour, .minute, .second], from: self)
        
        switch component {
        case .year:
            dateComponents.year = value
        case .month:
            dateComponents.month = value
        case .day:
            dateComponents.day = value
        case .hour:
            dateComponents.hour = value
        case .minute:
            dateComponents.minute = value
        case .second:
            dateComponents.second = value
        default:
            break
        }
        
        return calendar.date(from: dateComponents) ?? self
    }
    
    init(day: Int, month: Int, year: Int) {
        var components = DateComponents()
        components.day = day
        components.month = month
        components.year = year
        self = Calendar.current.date(from: components) ?? Date()
    }
    
    func withFormat(_ format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "pt-BR")
        return dateFormatter.string(from: self)
    }
    
    func fullDistance(from date: Date, resultIn component: Calendar.Component, calendar: Calendar = .current) -> Int? {
            calendar.dateComponents([component], from: self, to: date).value(for: component)
        }

    func distance(from date: Date, only component: Calendar.Component, calendar: Calendar = .current) -> Int {
        let days1 = calendar.component(component, from: self)
        let days2 = calendar.component(component, from: date)
        return days1 - days2
    }

    func hasSame(_ components: [Calendar.Component], as date: Date) -> Bool {
        var sum = 0
        for component in components {
            if distance(from: date, only: component) == 0 {
                sum += 1
            }
        }
        return sum == components.count
    }
}

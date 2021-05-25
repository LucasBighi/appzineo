//
//  CalendarExtensions.swift
//  Core
//
//  Created by Lucas Marques Bigh (P) on 12/05/21.
//

import Foundation

extension Calendar {
    mutating func localizedComponent(_ component: Component, value: Int = 1, locale: Locale = .current) -> String {
        guard let sinceUnits = self.date(byAdding: component, value: value, to: Date()) else {
            return ""
        }
        
        let formatter = DateComponentsFormatter()
        self.locale = locale
        formatter.calendar = self
        formatter.allowedUnits = [getUnit(from: component)]
        formatter.unitsStyle = .full
        guard let string = formatter.string(from: Date(), to: sinceUnits) else {
            return ""
        }
        if value == 1 {
            if component == .month {
                return string.replacingOccurrences(of: "\(value - 1)", with: "").trimmingCharacters(in: .whitespaces)
            } else {
                return string.replacingOccurrences(of: "\(value - 1)", with: "")
                             .replacingOccurrences(of: "s", with: "").trimmingCharacters(in: .whitespaces)
            }
        } else if component == .month {
            return string.replacingOccurrences(of: "\(value - 1)", with: "")
                         .replacingOccurrences(of: "es", with: "").trimmingCharacters(in: .whitespaces)
        } else {
            return string.replacingOccurrences(of: "\(value - 1)", with: "")
        }
    }
    
    private func getUnit(from component: Component) -> NSCalendar.Unit {
        let unit: NSCalendar.Unit
        
        switch component {
        case .era:
            unit = .era
        case .year:
            unit = .year
        case .month:
            unit = .month
        case .day:
            unit = .day
        case .hour:
            unit = .hour
        case .minute:
            unit = .minute
        case .second:
            unit = .second
        case .weekday:
            unit = .weekday
        case .weekdayOrdinal:
            unit = .weekdayOrdinal
        case .quarter:
            unit = .quarter
        case .weekOfMonth:
            unit = .weekOfMonth
        case .weekOfYear:
            unit = .weekOfYear
        case .yearForWeekOfYear:
            unit = .yearForWeekOfYear
        case .nanosecond:
            unit = .nanosecond
        case .calendar:
            unit = .calendar
        case .timeZone:
            unit = .timeZone
        default:
            unit = .calendar
        }
        return unit
    }
}

extension Calendar.Component {
    
    static var allCases: [Calendar.Component] {
        return [.year, .month, .day, .hour, .minute]
    }
    
    static var localizedCases: [String] {
        var calendar = Calendar.current
        return allCases.map { return calendar.localizedComponent($0, locale: Locale(identifier: "pt-BR")) }
    }
    
    var rawValue: Int {
        switch self {
        case .era:
            return 0
        case .year:
            return 1
        case .month:
            return 2
        case .day:
            return 3
        case .hour:
            return 4
        case .minute:
            return 5
        case .second:
            return 6
        case .weekday:
            return 7
        case .weekdayOrdinal:
            return 8
        case .quarter:
            return 9
        case .weekOfMonth:
            return 10
        case .weekOfYear:
            return 11
        case .yearForWeekOfYear:
            return 12
        case .nanosecond:
            return 13
        case .calendar:
            return 14
        case .timeZone:
            return 15
        @unknown default:
            return 100
        }
    }
    
    init?(_ localizedString: String) {
        switch localizedString.lowercased() {
        case "ano":
            self = .year
        case "mês":
            self = .month
        case "dia":
            self = .day
        case "hora":
            self = .hour
        case "minuto":
            self = .minute
        default:
            return nil
        }
    }
    
    init(_ value: Int) {
        switch value {
        case 0:
            self = .era
        case 1:
            self = .year
        case 2:
            self = .month
        case 3:
            self = .day
        case 4:
            self = .hour
        case 5:
            self = .minute
        case 6:
            self = .second
        case 7:
            self = .weekday
        case 8:
            self = .weekdayOrdinal
        case 9:
            self = .quarter
        case 10:
            self = .weekOfMonth
        case 11:
            self = .weekOfYear
        case 12:
            self = .yearForWeekOfYear
        case 13:
            self = .nanosecond
        case 14:
            self = .calendar
        case 15:
            self = .timeZone
        default:
            self = .calendar
        }
    }
}

//
//  RepeatType.swift
//  Schedules
//
//  Created by Lucas Marques Bigh (P) on 13/05/21.
//

import Foundation

struct RepeatType {
    var interval: Int
    var times: Int
    private var componentValue: Int
    
    init(interval: Int, times: Int, component: Calendar.Component) {
        self.interval = interval
        self.times = times
        self.componentValue = component.rawValue
    }
    
    var component: Calendar.Component {
        return Calendar.Component(componentValue)
    }
    
    var localizedDescription: String {
        var calendar = Calendar.current
        let locale = Locale(identifier: "pt-BR")
        let localizedComponent = "\(calendar.localizedComponent(component, value: interval, locale: locale))"
        if interval == 1 {
            switch component {
            case .year, .month, .day:
                return "Todo \(localizedComponent)"
            case .hour:
                return "Toda \(localizedComponent)"
            default:
                return "A cada \(localizedComponent)"
            }
        } else {
            return "A cada \(interval)\(localizedComponent)"
        }
    }
}

extension RepeatType: Codable {
    
    enum CodingKeys: String, CodingKey {
        case interval
        case times
        case component
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.interval = try container.decode(Int.self, forKey: .interval)
        self.times = try container.decode(Int.self, forKey: .times)
        self.componentValue = try container.decode(Int.self, forKey: .component)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(interval, forKey: .interval)
        try container.encode(times, forKey: .times)
        try container.encode(componentValue, forKey: .component)
    }
}

//
//  Schedule.swift
//  Schedules
//
//  Created by Lucas Marques Bigh (P) on 09/04/21.
//

import Foundation

struct Schedule {
    var id: String = ""
    let type: String
    let petId: String
    let title: String
    let date: Date
    let repeatType: RepeatType?
}

extension Schedule: Storable {
    var collectionPath: String {
        return "pets/\(petId)/schedules/\(id)"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case petId
        case title
        case date
        case repeatType
    }
    
    init() {
        self.type = ""
        self.petId = ""
        self.title = ""
        self.date = Date()
        self.repeatType = RepeatType(interval: 0, times: 0, component: .calendar)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.type = try container.decode(String.self, forKey: .type)
        self.petId = try container.decode(String.self, forKey: .petId)
        self.title = try container.decode(String.self, forKey: .title)
        self.date = try container.decode(Date.self, forKey: .date)
        self.repeatType = try container.decodeIfPresent(RepeatType.self, forKey: .repeatType)
    }
}

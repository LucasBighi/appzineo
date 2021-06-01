//
//  Owner.swift
//  Core
//
//  Created by Lucas Marques Bigh (P) on 19/05/21.
//

import Foundation
import UIKit

struct Owner: Storable, Entity {
    var id: String = ""
    let name: String
    let gender: Gender
    let bornDate: Date
    var image: UIImage?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case gender
        case bornDate
    }
    
    init() {
        self.name = ""
        self.gender = .undefined
        self.bornDate = Date()
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.gender = try container.decode(Gender.self, forKey: .gender)
        self.bornDate = try container.decode(Date.self, forKey: .bornDate)
    }
    
    init(id: String, name: String, gender: Gender, bornDate: Date) {
        self.id = id
        self.name = name
        self.gender = gender
        self.bornDate = bornDate
    }
    
    var age: String? {
        let dateComponentsFormatter = DateComponentsFormatter()
        dateComponentsFormatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth, .month, .year]
        dateComponentsFormatter.maximumUnitCount = 1
        dateComponentsFormatter.unitsStyle = .short
        return dateComponentsFormatter.string(from: bornDate, to: Date())
    }
    
    var collectionPath: String {
        return ""
    }
}

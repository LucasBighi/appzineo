//
//  Pet.swift
//  HugAPet
//
//  Created by Lucas Marques Bigh (P) on 07/04/21.
//

import Foundation
import UIKit

struct Pet: Storable, Entity {
    var id: String = ""
    let name: String
    let breed: Breed
    var image: UIImage?
    let bornDate: Date
    let gender: Gender
    let ownersIds: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case breed
        case image
        case bornDate
        case gender
        case ownersIds
    }
    
    init() {
        self.init(name: "", breed: Breed(type: "", name: ""), image: nil, bornDate: Date(), gender: .undefined)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.breed = try container.decode(Breed.self, forKey: .breed)
        self.bornDate = try container.decode(Date.self, forKey: .bornDate)
        self.gender = try container.decode(Gender.self, forKey: .gender)
        self.ownersIds = try container.decodeIfPresent([String].self, forKey: .ownersIds)
    }
    
    init(name: String, breed: Breed, image: UIImage?, bornDate: Date, gender: Gender) {
        self.name = name
        self.breed = breed
        self.image = image
        self.bornDate = bornDate
        self.gender = gender
        self.ownersIds = nil
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(breed, forKey: .breed)
        try container.encode(bornDate, forKey: .bornDate)
        try container.encode(gender, forKey: .gender)
        try container.encode(ownersIds, forKey: .ownersIds)
    }
    
    var age: String? {
        let dateComponentsFormatter = DateComponentsFormatter()
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "pt-BR")
        dateComponentsFormatter.calendar = calendar
        dateComponentsFormatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth, .month, .year]
        dateComponentsFormatter.maximumUnitCount = 1
        dateComponentsFormatter.unitsStyle = .short
        return dateComponentsFormatter.string(from: bornDate, to: Date())
    }
    
    var collectionPath: String {
        return "pets/\(id)"
    }
}

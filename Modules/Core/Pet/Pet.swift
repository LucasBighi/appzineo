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
    let owners: [Owner]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case breed
        case image
        case bornDate
        case gender
        case owners
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
        self.owners = try container.decode([Owner].self, forKey: .owners)
    }
    
    init(name: String, breed: Breed, image: UIImage?, bornDate: Date, gender: Gender) {
        self.name = name
        self.breed = breed
        self.image = image
        self.bornDate = bornDate
        self.gender = gender
        self.owners = [Owner(id: "nnLoY1ya8Cdt55qtqUnDTKRJkk82", name: "Lucas Bighi", gender: .boy, bornDate: Date(day: 23, month: 01, year: 1996))]
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(breed, forKey: .breed)
        try container.encode(bornDate, forKey: .bornDate)
        try container.encode(gender, forKey: .gender)
        try container.encode(owners, forKey: .owners)
    }
    
    var age: String? {
        let dateComponentsFormatter = DateComponentsFormatter()
        dateComponentsFormatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth, .month, .year]
        dateComponentsFormatter.maximumUnitCount = 1
        dateComponentsFormatter.unitsStyle = .short
        return dateComponentsFormatter.string(from: bornDate, to: Date())
    }
    
    var collectionPath: String {
        return "pets/\(id)"
    }
}

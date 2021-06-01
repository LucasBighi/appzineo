//
//  Address.swift
//  Core
//
//  Created by Lucas Marques Bigh (P) on 09/04/21.
//

import Foundation

struct Address {
    var street, number, addOn, district, city, state, zipCode: String
    
    var fullAddressDescription: String {
        return "\(district) - \(city), \(state)"
    }
    
    init(street: String, number: String, addOn: String, district: String, city: String, state: String, zipCode: String) {
        self.street = street
        self.number = number
        self.addOn = addOn
        self.district = district
        self.city = city
        self.state = state
        self.zipCode = zipCode
    }
    
    init() {
        self.street = ""
        self.number = ""
        self.addOn = ""
        self.district = ""
        self.city = ""
        self.state = ""
        self.zipCode = ""
    }
}

extension Address: Codable {
    
    enum CodingKeys: String, CodingKey {
        case street
        case number
        case addOn
        case district
        case city
        case state
        case zipCode
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.street = try container.decode(String.self, forKey: .street)
        self.number = try container.decode(String.self, forKey: .number)
        self.addOn = try container.decode(String.self, forKey: .addOn)
        self.district = try container.decode(String.self, forKey: .district)
        self.city = try container.decode(String.self, forKey: .city)
        self.state = try container.decode(String.self, forKey: .state)
        self.zipCode = try container.decode(String.self, forKey: .zipCode)
    }
}

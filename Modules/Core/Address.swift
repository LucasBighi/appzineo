//
//  Address.swift
//  Core
//
//  Created by Lucas Marques Bigh (P) on 09/04/21.
//

import Foundation

struct Address {
    var street, number, addOn, district, city, state, zipCode: String?
    
    var fullAddressDescription: String {
        return "\(street), nº \(number) \(addOn), \(district) - \(city), \(state) - \(zipCode)"
    }
    
//    init(street: String, number: String, addOn: String, district: String, city: String, state: String, zipCode: String) {
//        self.street = street
//        self.number = number
//        self.addOn = addOn
//        self.district = district
//        self.city = city
//        self.state = state
//        self.zipCode = zipCode
//    }
    
    init() {}
}

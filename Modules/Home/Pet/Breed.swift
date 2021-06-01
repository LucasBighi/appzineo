//
//  Breed.swift
//  Core
//
//  Created by Lucas Marques Bigh (P) on 12/05/21.
//

import Foundation

struct Breed: Codable {
    let type: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case type
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(String.self, forKey: .type)
        self.name = try container.decode(String.self, forKey: .name)
    }
    
    init(type: String, name: String) {
        self.type = type
        self.name = name
    }
}

extension Breed {
    static var allBreeds: [Breed] {
        guard let breeds = JSONManager.readJSON(filename: "Breeds",
                                                as: [Breed].self) else { return [Breed]() }
        return breeds
    }
    
    static func breeds(ofType type: String) -> [Breed] {
        return Breed.allBreeds.filter { $0.type == type .lowercased() }
    }
    
    static var allTypes: [String] {
        var types = [String]()
        
        for breed in Breed.allBreeds {
            if !types.contains(breed.type) {
                types.append(breed.type)
            }
        }
        return types
    }
}

//
//  Location.swift
//  Appzineo
//
//  Created by Lucas Marques Bigh (P) on 26/05/21.
//

import Foundation

struct Location {
    let latitude: Double
    let longitude: Double
}

extension Location: Codable {
    
    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.latitude = try container.decode(Double.self, forKey: .latitude)
        self.longitude = try container.decode(Double.self, forKey: .longitude)
    }
}

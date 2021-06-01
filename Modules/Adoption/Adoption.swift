//
//  Adoption.swift
//  Appzineo
//
//  Created by Lucas Marques Bigh (P) on 26/05/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Adoption {
    var id: String = ""
    let petId: String
    let advertiserId: String
    let phone: String
    let createdAt: Date
    let description: String
    let imagesUrls: [String]?
    let address: Address
}

extension Adoption: Storable {
    init() {
        self.petId = ""
        self.advertiserId = ""
        self.phone = ""
        self.createdAt = Date()
        self.description = ""
        self.imagesUrls = [""]
        self.address = Address()
    }
    
    var collectionPath: String {
        return "adoptions/\(id)"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case petId
        case advertiserId
        case phone
        case createdAt
        case description
        case imagesUrls
        case address
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.petId = try container.decode(String.self, forKey: .petId)
        self.advertiserId = try container.decode(String.self, forKey: .advertiserId)
        self.phone = try container.decode(String.self, forKey: .phone)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.description = try container.decode(String.self, forKey: .description)
        self.imagesUrls = try container.decodeIfPresent([String].self, forKey: .imagesUrls)
        self.address = try container.decode(Address.self, forKey: .address)
    }
}

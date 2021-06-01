//
//  Gender.swift
//  Core
//
//  Created by Lucas Marques Bigh (P) on 09/04/21.
//

import Foundation
import UIKit

enum Gender: String, Codable {
    case boy
    case girl
    case undefined
    
    init(from decoder: Decoder) throws {
        self.init(try decoder.singleValueContainer().decode(String.self))
    }
    
    init(_ value: String) {
        if value.lowercased() == "menino" {
            self = .boy
        } else if value.lowercased() == "menina" {
            self = .girl
        } else {
            self = .undefined
        }
    }
    
    var symbol: UIImage? {
        switch self {
        case .boy:
            return UIImage(named: "male")
        case .girl:
            return UIImage(named: "female")
        case .undefined:
            return nil
        }
    }
}

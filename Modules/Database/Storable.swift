//
//  Storable.swift
//  SpreadSheet
//
//  Created by Lucas Marques Bigh (P) on 03/05/21.
//

import Foundation

protocol Storable: Codable {
    var id: String { get set }
    var collectionPath: String { get }

    init()
}

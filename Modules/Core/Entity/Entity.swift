//
//  Entity.swift
//  Core
//
//  Created by Lucas Marques Bigh (P) on 09/04/21.
//

import Foundation

protocol Entity {
    var name: String { get }
    var gender: Gender { get }
    var bornDate: Date { get }
    var age: String? { get }
}

//
//  OwnerViewModel.swift
//  Appzineo
//
//  Created by Lucas Marques Bigh (P) on 27/05/21.
//

import Foundation

class OwnerViewModel {
    
    var owners = [Owner]()
    
    static let shared = OwnerViewModel()
    
    private init() {}
}

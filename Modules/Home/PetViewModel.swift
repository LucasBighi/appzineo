//
//  PetViewModel.swift
//  Appzineo
//
//  Created by Lucas Marques Bigh (P) on 24/05/21.
//

import Foundation

class PetViewModel {
    
    private var pets: [Pet]?
    
    static let shared = PetViewModel()
    
    private init() {}
    
    func getPets(_ completion: @escaping([Pet]) -> Void) {
        if let pets = pets {
            completion(pets)
        } else {
            Database.default.get(Pet.self) { result in
                switch result {
                case .success(let pets):
                    self.pets = pets
                    completion(pets)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

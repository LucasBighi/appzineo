//
//  PetViewModel.swift
//  Appzineo
//
//  Created by Lucas Marques Bigh (P) on 24/05/21.
//

import Foundation

class PetViewModel {
    
    var pets = [Pet]()
    
    static let shared = PetViewModel()
    
    private init() {}
    
    func getPets(_ completion: @escaping() -> Void) {
        Database.default.get(Pet.self) { result in
            switch result {
            case .success(let pets):
                self.pets = pets
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getPet(ofSchedule schedule: Schedule) -> Pet? {
        return pets.first(where: { $0.id == schedule.petId })
    }
}

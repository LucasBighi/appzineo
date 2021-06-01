//
//  ScheduleViewModel.swift
//  Appzineo
//
//  Created by Lucas Marques Bigh (P) on 24/05/21.
//

import Foundation

class ScheduleViewModel {
    
    var schedules = [Schedule]()
    
    private init() {}
    
    static let shared = ScheduleViewModel()
    
    func getAllSchedules(_ completion: @escaping(() -> Void)) {
        PetViewModel.shared.pets.forEach {
            self.getSchedules(ofPet: $0) { schedules in
                self.schedules.append(contentsOf: schedules)
            }
        }
        completion()
    }
    
    func getSchedules(ofPet pet: Pet, _ completion: @escaping(([Schedule]) -> Void)) {
        let collectionPath = "\(pet.collectionPath)/schedules"
        Database.default.get(collectionPath: collectionPath, as: Schedule.self) { result in
            switch result {
            case .success(let schedules):
                self.schedules = schedules
                completion(schedules)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func schedules(at date: Date) -> [Schedule]? {
        return schedules.filter { $0.date.hasSame([.day, .month, .year], as: date) }
    }
}

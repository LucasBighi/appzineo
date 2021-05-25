//
//  HomeViewModel.swift
//  Appzineo
//
//  Created by Lucas Marques Bigh (P) on 24/05/21.
//

import Foundation

class HomeViewModel {
    
    static let shared = HomeViewModel()
    
    private var petViewModel = PetViewModel.shared
    private var scheduleViewModel = ScheduleViewModel.shared
    
    var sections = [SectionData(title: "Meus Pets", data: nil),
                    SectionData(title: "Próximos eventos", data: nil)]
    
    private init() {}
    
    func getHomeData(_ completion: @escaping() -> Void) {
        petViewModel.getPets { pets in
            self.sections[0].data = pets
            pets.forEach {
                self.scheduleViewModel.getSchedules(ofPet: $0) { schedules in
                    self.sections[1].data = schedules
                }
            }
            completion()
        }
    }
    
    func title(of section: Int) -> String {
        return sections[section].title
    }
    
    func sectionData(at section: Int) -> [Any]? {
        return sections[section].data
    }
    
    func numberOfRows(in section: Int) -> Int {
        let sectionCount = sectionData(at: section)?.count ?? 0
        return section == 0 ? sectionCount + 1 : sectionCount
    }
}

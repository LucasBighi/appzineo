//
//  SectionData.swift
//  Appzineo
//
//  Created by Lucas Marques Bigh (P) on 24/05/21.
//

import Foundation

class SectionData {
    var title: String
    var data: [Any]?
    
    var numberOfItems: Int {
        return data?.count ?? 0
    }
    
    init(title: String, data: [Any]?) {
        self.title = title
        self.data = data
    }
}

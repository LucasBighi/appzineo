//
//  ScheduleNavigationController.swift
//  Schedules
//
//  Created by Lucas Marques Bigh (P) on 19/04/21.
//

import UIKit

class ScheduleNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.prefersLargeTitles = true
        navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    @objc private func addAction() {
        
    }
}

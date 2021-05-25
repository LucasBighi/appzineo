//
//  HomeNavigationController.swift
//  Home
//
//  Created by Lucas Marques Bigh (P) on 12/05/21.
//

import UIKit

class HomeNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.prefersLargeTitles = true
        navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.purple]
    }
}

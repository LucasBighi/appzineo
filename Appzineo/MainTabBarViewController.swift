//
//  MainTabBarViewController.swift
//  PetsCo
//
//  Created by Lucas Marques Bigh (P) on 15/04/21.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        UITabBar.appearance().barTintColor = .white
        tabBar.tintColor = .purple
        setupVCs()
    }
    
    private func setupVCs() {
        viewControllers = [
            HomeNavigationController(rootViewController: HomeViewController(tabBarTitle: "Home", tabBarImage: UIImage())),
            ScheduleNavigationController(rootViewController: SchedulesViewController(tabBarTitle: "Agendínea", tabBarImage: UIImage()))
        ]
    }
}

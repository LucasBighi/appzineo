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
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        viewControllers = [
            AppzineoNavigationController(root: HomeViewController(), title: "Home", titleColor: .purple, image: UIImage()),
            AppzineoNavigationController(root: SchedulesViewController(), title: "Agendínea", titleColor: .white, image: UIImage()),
            AppzineoNavigationController(root: AdoptionViewController(), title: "Adoções", titleColor: .purple, image: UIImage())
        ]
    }
}

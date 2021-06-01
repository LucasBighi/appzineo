//
//  AdoptionNavigationController.swift
//  Appzineo
//
//  Created by Lucas Marques Bigh (P) on 25/05/21.
//

import UIKit

class AppzineoNavigationController: UINavigationController {
    
    private var titleColor: UIColor = .black
    
    convenience init(root: UIViewController, title: String, titleColor: UIColor, image: UIImage) {
        let rootViewController = root
        rootViewController.title = title
        rootViewController.tabBarItem.title = title
        rootViewController.tabBarItem.image = image
        
        self.init(rootViewController: rootViewController)
        
        self.titleColor = titleColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationBar.prefersLargeTitles = true
        navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor]
    }
}

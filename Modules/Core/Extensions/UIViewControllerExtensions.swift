//
//  UIViewControllerExtensions.swift
//  Core
//
//  Created by Lucas Marques Bigh (P) on 16/04/21.
//

import UIKit

extension UIViewController {
    convenience init(tabBarTitle: String, tabBarImage: UIImage) {
        self.init()
        self.title = tabBarTitle
        self.tabBarItem.title = tabBarTitle
        self.tabBarItem.image = tabBarImage
    }
}

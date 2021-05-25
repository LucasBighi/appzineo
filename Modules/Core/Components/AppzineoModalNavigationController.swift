//
//  AppzineoModalNavigationController.swift
//  Core
//
//  Created by Lucas Marques Bigh (P) on 10/05/21.
//

import UIKit

protocol AppzineoModalNavigationControllerDelegate: NSObjectProtocol {
    func didDisappear()
}

class AppzineoModalNavigationController: UINavigationController {
    
    weak var modalDelegate: AppzineoModalNavigationControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let viewController = visibleViewController {
            let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction))
            cancelButton.tintColor = .purple
            viewController.navigationItem.rightBarButtonItem = cancelButton
        }
    }
    
    @objc private func cancelAction() {
        dismiss(animated: true)
    }
}

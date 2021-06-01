//
//  AppzineoBarButtonItem.swift
//  Appzineo
//
//  Created by Lucas Marques Bigh (P) on 28/05/21.
//

import UIKit

class AppzineoBarButtonItem: UIBarButtonItem {
    
    private var _action: (() -> ())?
    
    convenience init(image: UIImage?, tint: UIColor, action: @escaping() -> Void) {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.backgroundColor = .clear
        view.applyBlurEffect()
        
        let imageView = UIImageView(frame: CGRect(x: 5, y: 5, width: 30, height: 30))
        imageView.image = image
        imageView.tintColor = tint
        
        view.addSubview(imageView)

        self.init(customView: view)
        self._action = action
        let backTap = UITapGestureRecognizer(target: self, action: #selector(objcAction))
        view.addGestureRecognizer(backTap)
    }
    
    @objc private func objcAction() {
        _action?()
    }
}

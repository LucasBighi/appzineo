//
//  PetsCoArrowButton.swift
//  Core
//
//  Created by Lucas Marques Bigh (P) on 16/04/21.
//

import UIKit

class PetsCoArrowButton: UIButton {
    
    convenience init(arrowImage: UIImage?) {
        self.init()
        setImage(arrowImage ?? #imageLiteral(resourceName: "left-arrow"), for: .normal)
        backgroundColor = UIColor.black.withAlphaComponent(0.3)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        clipsToBounds = true
        layer.cornerRadius = bounds.height / 2
    }
}

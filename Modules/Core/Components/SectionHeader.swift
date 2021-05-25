//
//  SectionHeader.swift
//  Appzineo
//
//  Created by Lucas Marques Bigh (P) on 24/05/21.
//

import UIKit

class SectionHeader: UICollectionReusableView {
    
    var label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.sizeToFit()
        return label
    }()
    
    private func commonInit() {
        addSubview(label)
        label.addAnchors([.top(equalTo: topAnchor),
                          .leading(equalTo: leadingAnchor, constant: 20),
                          .trailing(equalTo: trailingAnchor),
                          .bottom(equalTo: bottomAnchor)])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
}

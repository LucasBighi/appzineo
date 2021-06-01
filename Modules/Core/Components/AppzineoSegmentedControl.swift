//
//  AppzineoSegmentedControl.swift
//  Appzineo
//
//  Created by Lucas Marques Bigh (P) on 31/05/21.
//

import UIKit

class AppzineoSegmentedControl: UIView {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        let types = Breed.allTypes
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 10
        
        scrollView.addSubview(stackView)
        stackView.addAnchors([.top(equalTo: scrollView.topAnchor),
                              .leading(equalTo: scrollView.leadingAnchor),
                              .bottom(equalTo: scrollView.bottomAnchor),
                              .trailing(equalTo: scrollView.trailingAnchor)])
        
        for (index, type) in types.enumerated() {
            let button = UIButton()
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            imageView.image = UIImage(named: type)
            imageView.tintColor = .labelBlack
            button.setImage(imageView.asImage(), for: .normal)
            button.layer.cornerRadius = 25
            button.layer.borderColor = UIColor.labelBlack.cgColor
            button.layer.borderWidth = 1
            button.backgroundColor = .clear
            stackView.addArrangedSubview(button)
            button.addAnchors([.width(constant: 50, aspectRadio: true)])
        }
        return scrollView
    }()
    
    private func commonInit() {
        setupScrollView()
    }
    
    private func setupScrollView() {
        addSubview(scrollView)
        scrollView.addAnchors([.top(equalTo: topAnchor),
                               .leading(equalTo: leadingAnchor),
                               .bottom(equalTo: bottomAnchor),
                               .trailing(equalTo: trailingAnchor)])
        
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

//
//  PetsCoSegmentedControl.swift
//  Schedules
//
//  Created by Lucas Marques Bigh (P) on 12/04/21.
//

import UIKit

class PetsCoSegmentedControl: UISegmentedControl {
    
    var selectedItem: String? {
        return titleForSegment(at: selectedSegmentIndex)
    }
    
    private let markerView: UIView = {
        let view = UIView()
        return view
    }()
    
    override func draw(_ rect: CGRect) {
        setTitleTextAttributes([NSAttributedString.Key.foregroundColor : tintColor ?? .black,
                                 NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .bold)], for: .selected)
        setTitleTextAttributes([NSAttributedString.Key.foregroundColor : tintColor ?? .black,
                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .regular)], for: .normal)
        setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        setBackgroundImage(UIImage(), for: .selected, barMetrics: .default)
        
        let segmentWidth = frame.width / CGFloat(numberOfSegments)
        addTarget(self, action: #selector(moveMarker), for: .valueChanged)
        markerView.backgroundColor = tintColor
        markerView.frame = CGRect(x: segmentWidth / 2 - 5,
                                  y: frame.height - 11,
                                  width: 8,
                                  height: 8)
        markerView.layer.cornerRadius = markerView.bounds.height / 2
        addSubview(markerView)
        
        selectedSegmentIndex = 0
    }
    
    @objc private func moveMarker() {
        UIView.animate(withDuration: 0.3) {
            self.markerView.frame.origin.x = self.frameForSegment(atIndex: self.selectedSegmentIndex).midX - self.markerView.bounds.width / 2
        }
    }
}

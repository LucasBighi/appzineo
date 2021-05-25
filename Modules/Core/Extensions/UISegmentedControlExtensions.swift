//
//  UISegmentedControlExtensions.swift
//  Core
//
//  Created by Lucas Marques Bigh (P) on 16/04/21.
//

import UIKit

extension UISegmentedControl {

    func frameForSegment(atIndex index: Int) -> CGRect {
        let segmentWidth = self.frame.width / CGFloat(numberOfSegments)
        var left : CGFloat = 0
        for i in 0..<numberOfSegments {
            let w = segmentWidth
            if i == index {
                let off = CGFloat(i)
                return CGRect(x: left + off, y: bounds.minY, width: w, height: bounds.height)
            }
            left += w
        }
        return .zero
    }
}

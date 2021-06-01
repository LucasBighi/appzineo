//
//  UIViewExtensions.swift
//  Core
//
//  Created by Lucas Marques Bigh (P) on 19/04/21.
//

import UIKit

enum Anchor {
    case top(equalTo: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = 0)
    case leading(equalTo: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = 0)
    case trailing(equalTo: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = 0)
    case bottom(equalTo: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = 0)
    case centerX(equalTo: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = 0)
    case centerY(equalTo: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = 0)
    case height(equalTo: NSLayoutAnchor<NSLayoutDimension>? = nil, constant: CGFloat = 0, aspectRadio: Bool = false)
    case width(equalTo: NSLayoutAnchor<NSLayoutDimension>? = nil, constant: CGFloat = 0, aspectRadio: Bool = false)
}

extension UIView {
    func addAnchors(_ anchors: [Anchor]) {
        translatesAutoresizingMaskIntoConstraints = false
        for anchor in anchors {
            switch anchor {
            case .top(let equalTo, let constant):
                topAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
            case .leading(let equalTo, let constant):
                leadingAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
            case .trailing(let equalTo, let constant):
                trailingAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
            case .bottom(let equalTo, let constant):
                bottomAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
            case .centerX(let equalTo, let constant):
                centerXAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
            case .centerY(let equalTo, let constant):
                centerYAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
            case .height(let equalTo, let constant, let aspectRadio):
                if let equalTo = equalTo {
                    heightAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
                } else {
                    heightAnchor.constraint(equalToConstant: constant).isActive = true
                }
                if aspectRadio {
                   widthAnchor.constraint(equalTo: heightAnchor).isActive = true
               }
            case .width(let equalTo, let constant, let aspectRadio):
                if let equalTo = equalTo {
                    widthAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
                } else {
                    widthAnchor.constraint(equalToConstant: constant).isActive = true
                }
                if aspectRadio {
                   heightAnchor.constraint(equalTo: widthAnchor).isActive = true
               }
            }
        }
    }
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        layoutSubviews()
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func applyBlurEffect() {
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
    }
    
    func asImage() -> UIImage {
        UIGraphicsBeginImageContext(frame.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return UIImage(cgImage: image!.cgImage!)
    }
}

//
//  UIView.swift
//  GYG
//
//  Created by Mohamed Hamed on 7/21/18.
//  Copyright © 2018 Hamed. All rights reserved.
//

import Foundation
import Foundation
import UIKit

extension UIView {
    
    func roundCorners(withRadius cornerRadius: CGFloat,
                      borderWidth: CGFloat = 0,
                      borderColor: UIColor? = .clear) {
        layer.borderWidth   = borderWidth
        layer.borderColor   = borderColor?.cgColor
        layer.cornerRadius  = cornerRadius
        layer.masksToBounds = true
        clipsToBounds       = true
    }
    
}

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var isRounded: Bool {
        get {
            return true
        }
        set {
            if isRounded {
                roundCorners(withRadius: frame.height / 2)
            }
        }
    }
}

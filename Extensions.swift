//
//  Extensions.swift
//  CircleMove
//
//  Created by Quasar on 21.03.2024.
//

import Foundation
import UIKit

extension UIView {
    func rotate360Degrees(duration: CFTimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 2.0)
        rotateAnimation.duration = duration
        rotateAnimation.repeatCount = .greatestFiniteMagnitude // Repeat indefinitely

        if let delegate: AnyObject = completionDelegate {
            rotateAnimation.delegate = (delegate as! any CAAnimationDelegate)
        }
        self.layer.add(rotateAnimation, forKey: nil)
    }
}





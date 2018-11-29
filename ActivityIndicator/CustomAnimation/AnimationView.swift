//
//  AnimationView.swift
//  Sirius
//
//  Created by LTT-ThanhLH on 12/22/17.
//  Copyright © 2017 Monstar Lab, Inc. All rights reserved.
//

import UIKit

@IBDesignable
open class AnimationView: UIView, ActivityIndicatorAnimatable {
    
    // MARK: ActivityIndicatorAnimatable
    open var animationType: ActivityIndicatorType = .ballScallRippleMultiple
    @IBInspectable var _animationType: String? {
        didSet {
            if let type = _animationType, let animationType = ActivityIndicatorType(string: type) {
                self.animationType = animationType
            } else {
                animationType = .none
            }
        }
    }
    @IBInspectable open var color: UIColor = .white
    @IBInspectable open var hidesWhenStopped: Bool = true
    open var isAnimating: Bool = false
}

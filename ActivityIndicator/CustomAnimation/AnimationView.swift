//
//  AnimationView.swift
//  Sirius
//
//  Created by LTT-ThanhLH on 12/22/17.
//  Copyright © 2017 Monstar Lab, Inc. All rights reserved.
//

import UIKit

public enum ActivityIndicatorType: String, AnimationEnum {
    case none
    case ballScallRippleMultiple
}

public protocol ActivityIndicatorAnimatable: class {
    /// Animation type
    var animationType: ActivityIndicatorType { get set }
    /// Color of the indicator
    var color: UIColor { get set }
    /// Specify whether hide the indicator when the animation stopped
    var hidesWhenStopped: Bool { get set }
    /// Animating status
    var isAnimating: Bool { get set }
}

public extension ActivityIndicatorAnimatable where Self: UIView {
    
    /// Start animating the activity indicator
    public func startAnimating() {
        isHidden = false
        configureLayer()
        isAnimating = true
    }
    
    /// Stop animating the activity indicator
    public func stopAnimating() {
        layer.sublayers = nil
        isAnimating = false
        if hidesWhenStopped {
            isHidden = true
        }
    }
    
}

private extension ActivityIndicatorAnimatable where Self: UIView {
    
    func configureLayer() {
        guard layer.sublayers == nil else {
            return
        }
        
        if case .none = animationType {
            return
        }
        
        let activityIndicator = ActivityIndicatorFactory.makeActivityIndicator(activityIndicatorType: animationType)
        activityIndicator.configureAnimation(in: layer, size: bounds.size, color: color)
        layer.speed = 1
    }
}

public struct ActivityIndicatorFactory {
    public static func makeActivityIndicator(activityIndicatorType: ActivityIndicatorType) -> ActivityIndicatorAnimating {
        switch activityIndicatorType {
        case .none:
            return NoneAnimation()
        case .ballScallRippleMultiple:
            return AnimationBallScaleRippleMultiple()
        }
    }
}

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

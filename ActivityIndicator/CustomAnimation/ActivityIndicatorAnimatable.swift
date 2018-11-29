//
//  ActivityIndicatorAnimatable.swift
//  ActivityIndicator
//
//  Created by Thành Lã on 11/29/18.
//  Copyright © 2018 MonstarLab. All rights reserved.
//

import UIKit

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

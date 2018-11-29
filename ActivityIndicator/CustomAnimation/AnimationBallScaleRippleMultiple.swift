//
//  AnimationBallScaleRippleMultiple.swift
//  Polar
//
//  Created by Thành Lã on 9/20/18.
//  Copyright © 2018 MonstarLab. All rights reserved.
//

import UIKit

public protocol ActivityIndicatorAnimating: class {
    func configureAnimation(in layer: CALayer, size: CGSize, color: UIColor)
}

extension ActivityIndicatorAnimating {
    public func configureAnimation(in layer: CALayer, size: CGSize, color: UIColor) {}
}

public class NoneAnimation: ActivityIndicatorAnimating {}

public class AnimationBallScaleRippleMultiple: ActivityIndicatorAnimating {
    
    // MARK: Properties
    fileprivate let duration: CFTimeInterval = 3.6
    
    // MARK: ActivityIndicatorAnimating
    public func configureAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
        let beginTime = CACurrentMediaTime()
        let beginTimes = (0...5).map { i in 0.6 * Double(i) + 0.3 }
        
        // Scale animation
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.duration = duration
        scaleAnimation.fromValue = 0.1
        scaleAnimation.toValue = 1
        
        // Opacity animation
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimation.duration = duration
        opacityAnimation.keyTimes = [0, 0.05, 1]
        opacityAnimation.values = [1, 1, 0]
        
        // Animation
        let animation = CAAnimationGroup()
        animation.animations = [scaleAnimation, opacityAnimation]
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = duration
        animation.repeatCount = HUGE
        animation.isRemovedOnCompletion = false
        
        // Draw balls
        for i in 0 ..< beginTimes.count {
            let circle = ActivityIndicatorShape.ring.makeLayer(size: size, color: color)
            let frame = CGRect(x: (layer.bounds.size.width - size.width) / 2,
                               y: (layer.bounds.size.height - size.height) / 2,
                               width: size.width,
                               height: size.height)
            
            animation.beginTime = beginTime + beginTimes[i]
            circle.frame = frame
            circle.opacity = 0
            circle.add(animation, forKey: "animation")
            layer.addSublayer(circle)
        }
    }
}

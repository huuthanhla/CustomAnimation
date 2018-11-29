//
//  CustomAnimation.swift
//  Sirius
//
//  Created by LTT-ThanhLH on 12/22/17.
//  Copyright © 2017 Monstar Lab, Inc. All rights reserved.
//

import UIKit

enum ActivityIndicatorShape {
    case circle
    case ring
    func makeLayer(size: CGSize, color: UIColor) -> CALayer {
        switch self {
        case .circle:
            return makeCircleShapeLayer(with: size, color: color)
        case .ring:
            return makeRingShapeLayer(with: size, color: color, lineWidth: 1.5)
        }
    }
}

// MARK: - Circles

private extension ActivityIndicatorShape {
    
    func makeCircleShapeLayer(with size: CGSize, color: UIColor) -> CAShapeLayer {
        let layer = CAShapeLayer()
        let path = UIBezierPath()
        path.addArc(withCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                    radius: size.width / 2,
                    startAngle: -(.pi / 2),
                    endAngle: .pi + .pi / 2,
                    clockwise: true)
        layer.fillColor = nil
        layer.strokeColor = color.cgColor
        layer.lineWidth = 2
        layer.fillColor = color.cgColor
        layer.apply(path: path, size: size)
        return layer
    }
    
    func makeRingShapeLayer(with size: CGSize, color: UIColor, lineWidth: CGFloat) -> CAShapeLayer {
        let layer = CAShapeLayer()
        let path = UIBezierPath()
        path.addArc(withCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                    radius: size.width / 2,
                    startAngle: 0,
                    endAngle: 2 * CGFloat(Double.pi),
                    clockwise: false)
        layer.fillColor = nil
        layer.strokeColor = color.cgColor
        layer.lineWidth = lineWidth
        layer.apply(path: path, size: size)
        return layer
    }
}

private extension CAShapeLayer {
    func apply(path: UIBezierPath, size: CGSize) {
        self.backgroundColor = nil
        self.path = path.cgPath
        self.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    }
}

//
//  CustomAnimation.swift
//  Sirius
//
//  Created by LTT-ThanhLH on 12/22/17.
//  Copyright © 2017 Monstar Lab, Inc. All rights reserved.
//

import UIKit

public enum TimingFunctionType {
    case linear
    case easeInOut
    case easeOutExpo
    case custom((x: Float, y: Float), (x: Float, y: Float))
    case none
}

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

// MARK: - TimingFunctionType

internal extension CAAnimation {
    var timingFunctionType: TimingFunctionType? {
        get {
            fatalError("You cannot read timingFunctionType, read instead timingFunction.")
        }
        set {
            self.timingFunction = newValue?.caType
        }
    }
}

internal extension CAKeyframeAnimation {
    var timingFunctionsType: [TimingFunctionType]? {
        get {
            fatalError("You cannot read timingFunctionType, read instead timingFunction.")
        }
        set {
            if let types = newValue {
                self.timingFunctions = types.map { $0.caType }
            } else {
                self.timingFunctions = nil
            }
        }
    }
}

extension TimingFunctionType {
    public var caType: CAMediaTimingFunction {
        switch self {
        case .linear:
            return .linear
        case .easeInOut:
            return .easeInOut
        case .easeOutExpo:
            return .easeOutExpo
        case .custom(let c1, let c2):
            return CAMediaTimingFunction(controlPoints: c1.x, c1.y, c2.x, c2.y)
        case .none:
            return .default
        }
    }
}

extension TimingFunctionType: AnimationEnum {
    
    public init(string: String?) {
        guard let string = string else {
            self = .none
            return
        }
        
        let (name, params) = TimingFunctionType.extractNameAndParams(from: string)
        
        switch name {
        case "linear":
            self = .linear
        case "custom" where params.count == 4:
            let c1 = (params[0].toFloat() ?? 0, params[1].toFloat() ?? 0)
            let c2 = (params[2].toFloat() ?? 0, params[3].toFloat() ?? 0)
            self = .custom(c1, c2)
        case "easeOutExpo":
            self = .easeOutExpo
            
        default:
            self = .none
        }
    }
}

extension CAMediaTimingFunction {
    @nonobjc public static let linear = CAMediaTimingFunction(name: .linear)
    @nonobjc public static let easeOutExpo = CAMediaTimingFunction(controlPoints: 0.19, 1, 0.22, 1)
    @nonobjc public static let easeInOut = CAMediaTimingFunction(name: .easeInEaseOut)
    @nonobjc public static let `default`  = CAMediaTimingFunction(name: .default)
}

extension String {
    func toDouble() -> Double? {
        return Double(self)
    }
    
    func toFloat() -> Float? {
        return Float(self)
    }
}

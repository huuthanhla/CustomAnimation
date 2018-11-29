//
//  TimingFunctionType.swift
//  ActivityIndicator
//
//  Created by Thành Lã on 11/29/18.
//  Copyright © 2018 MonstarLab. All rights reserved.
//

import UIKit

// MARK: - TimingFunctionType

public enum TimingFunctionType {
    case linear
    case easeInOut
    case easeOutExpo
    case custom((x: Float, y: Float), (x: Float, y: Float))
    case none
}

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

//
//  ActivityIndicatorFactory.swift
//  ActivityIndicator
//
//  Created by Thành Lã on 11/29/18.
//  Copyright © 2018 MonstarLab. All rights reserved.
//

import Foundation


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

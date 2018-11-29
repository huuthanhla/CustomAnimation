//
//  AnimationEnum.swift
//  Sirius
//
//  Created by LTT-ThanhLH on 12/22/17.
//  Copyright © 2017 Monstar Lab, Inc. All rights reserved.
//

import Foundation

public protocol AnimationEnum {
    init?(string: String?)
}

public extension AnimationEnum {
    static func extractNameAndParams(from string: String) -> (name: String, params: [String]) {
        let tokens = string.lowercased().components(separatedBy: CharacterSet(charactersIn: "()")).filter { !$0.isEmpty }
        let name = tokens.first ?? ""
        let paramsString = tokens.count >= 2 ? tokens[1] : ""
        let params = paramsString.components(separatedBy: ",").filter { !$0.isEmpty }.map { $0.trimmingCharacters(in: .whitespaces) }
        
        return (name: name, params: params)
    }
}

extension AnimationEnum {
    init(string: String?, default defaultValue: Self) {
        self = Self(string: string) ?? defaultValue
    }
}

public extension AnimationEnum where Self: RawRepresentable & Hashable {
    init?(string: String?) {
        let lowerString = string?.lowercased()
        let iterator = iterateEnum(from: Self.self)
        for e in iterator {
            if String(describing: e.rawValue).lowercased() == lowerString {
                self = e as Self
                return
            }
        }
        return nil
    }
}

func iterateEnum<T: Hashable>(from: T.Type) -> AnyIterator<T> {
    var x = 0
    return AnyIterator {
        let next = withUnsafePointer(to: &x) {
            $0.withMemoryRebound(to: T.self, capacity: 1) { $0.pointee }
        }
        defer {
            x += 1
        }
        return next.hashValue == x ? next : nil
    }
}

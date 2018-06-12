//
//  CGFloatExtensions.swift
//  GameElementExample
//
//  Created by Matija Kruljac on 11/30/17.
//  Copyright © 2017 Matija Kruljac. All rights reserved.
//

import CoreGraphics

extension CGFloat {
    
    public static func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }

    public static func random(min: CGFloat, max: CGFloat) -> CGFloat {
        assert(min < max)
        return CGFloat.random() * (max - min) + min
    }
    
    public func degreesToRadians() -> CGFloat {
        return CGFloat(Double.pi) * self / 180.0
    }
}

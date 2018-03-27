//
//  CGFloatExtensions.swift
//  GameElementExample
//
//  Created by Matija Kruljac on 11/30/17.
//  Copyright © 2017 Matija Kruljac. All rights reserved.
//

import CoreGraphics

extension CGFloat {
    
    /**
     * Returns a random floating point number between 0.0 and 1.0, inclusive.
     */
    public static func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    /**
     * Returns a random floating point number in the range min...max, inclusive.
     */
    public static func random(min: CGFloat, max: CGFloat) -> CGFloat {
        assert(min < max)
        return CGFloat.random() * (max - min) + min
    }
    
    /**
     * Converts an angle in degrees to radians.
     */
    public func degreesToRadians() -> CGFloat {
        return CGFloat(Double.pi) * self / 180.0
    }
}

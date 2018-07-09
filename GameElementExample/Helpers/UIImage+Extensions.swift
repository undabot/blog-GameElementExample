//
//  UIImage+Extensions.swift
//  GameElementExample
//
//  Created by Matija Kruljac on 7/9/18.
//  Copyright © 2018 Matija Kruljac. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    func imageWithInsets(_ insets: UIEdgeInsets) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(
            CGSize(width: size.width + insets.left + insets.right,
                   height: size.height + insets.top + insets.bottom), false, scale)
        _ = UIGraphicsGetCurrentContext()
        let origin = CGPoint(x: insets.left, y: insets.top)
        draw(at: origin)
        let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return imageWithInsets
    }
}

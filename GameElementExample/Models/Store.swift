//
//  Store.swift
//  GameElementExample
//
//  Created by Matija Kruljac on 12/14/17.
//  Copyright © 2017 Matija Kruljac. All rights reserved.
//

import Foundation
import UIKit

class Store {
    
    let identifier: Int
    let name: String
    let image: UIImage
    var couponScore: Int
    let maxCuponScore: Int
    let backgroundColor: UIColor
    
    init(identifier: Int, name: String, image: UIImage, cuponScore: Int,
         maxCuponScore: Int, backgroundColor: UIColor) {
        self.identifier = identifier
        self.name = name
        self.image = image
        self.couponScore = cuponScore
        self.maxCuponScore = maxCuponScore
        self.backgroundColor = backgroundColor
    }
}

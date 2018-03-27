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
    var cuponScore: Int
    let maxCuponScore: Int
    let backgroundColor: UIColor
    
    init(identifier: Int, name: String, image: UIImage, cuponScore: Int, maxCuponScore: Int, backgroundColor: UIColor) {
        self.identifier = identifier
        self.name = name
        self.image = image
        self.cuponScore = cuponScore
        self.maxCuponScore = maxCuponScore
        self.backgroundColor = backgroundColor
    }
    
    static func generateData() -> [Store] {
        let store1 = Store(identifier: 111, name: "Ultrapaar", image: #imageLiteral(resourceName: "ic_ultrapaar"), cuponScore: 0, maxCuponScore: 110, backgroundColor: UIColor(red: 0/255, green: 214/255, blue: 28/255, alpha: 1.0))
        let store2 = Store(identifier: 222, name: "Pylla", image: #imageLiteral(resourceName: "ic_pylla"), cuponScore: 0, maxCuponScore: 25, backgroundColor: UIColor(red: 0/255, green: 119/255, blue: 170/255, alpha: 1.0))
        let store3 = Store(identifier: 333, name: "Kingscoop", image: #imageLiteral(resourceName: "ic_kingscoop"), cuponScore: 0, maxCuponScore: 40, backgroundColor: UIColor(red: 255/255, green: 204/255, blue: 0/255, alpha: 1.0))
        return [store1, store2, store3]
    }
}

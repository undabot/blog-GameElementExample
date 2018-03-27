//
//  GameViewControllerDelegate.swift
//  GameElementExample
//
//  Created by Matija Kruljac on 12/14/17.
//  Copyright © 2017 Matija Kruljac. All rights reserved.
//

import Foundation

protocol GameViewControllerDelegate: class {
    
    func scoreValueChanged(for store: Store)
}

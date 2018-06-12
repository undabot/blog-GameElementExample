//
//  SKScene+Extensions.swift
//  GameElementExample
//
//  Created by Matija Kruljac on 3/23/18.
//  Copyright © 2018 Matija Kruljac. All rights reserved.
//

import Foundation
import SpriteKit

extension SKScene {
    
    var isGamePaused: Bool {
        guard let isPaused = view?.isPaused else {
            return false
        }
        return isPaused
    }
    
    func pauseTheGame() {
        view?.isPaused = true
    }
    
    func unpauseTheGame() {
        view?.isPaused = false
    }
}

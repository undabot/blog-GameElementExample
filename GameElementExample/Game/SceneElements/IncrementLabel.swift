//
//  PlusOneLabel.swift
//  GameElementExample
//
//  Created by Matija Kruljac on 12/13/17.
//  Copyright © 2017 Matija Kruljac. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class IncrementLabel: SKLabelNode {
    
    private let value: Int
    private let cartNodeFrame: CGRect
    
    init(with value: Int, for cartNodeFrame: CGRect) {
        self.value = value
        self.cartNodeFrame = cartNodeFrame
        super.init()
        setupText()
        zPosition = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupText() {
        fontColor = .white
        text = "+\(value)"
        fontName = "AvenirNext-Medium"
        fontSize = 20
        horizontalAlignmentMode = .left
        verticalAlignmentMode = .top
        position = CGPoint(x: cartNodeFrame.origin.x+cartNodeFrame.size.width/2,
                           y: cartNodeFrame.origin.y+60)
    }
    
    func startAnimation() {
        let newXPosition = calculateRandomX()
        let moveUp = SKAction.move(to: CGPoint(x: newXPosition, y: position.y+80), duration: 0.9)
        let scaleUp = SKAction.scale(to: 1.5, duration: 0.9)
        let fadeout = SKAction.fadeOut(withDuration: 0.8)
        let actionSequenceGroup = SKAction.group([moveUp, scaleUp, fadeout])
        run(actionSequenceGroup) { [weak self] in
            self?.removeFromParent()
        }
    }
    
    private func calculateRandomX() -> CGFloat {
        let minValue = position.x-cartNodeFrame.width
        let maxValue = position.x+cartNodeFrame.width
        return CGFloat.random(min: minValue, max: maxValue)
    }
}

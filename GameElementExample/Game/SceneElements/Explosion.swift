//
//  Explosion.swift
//  GameElementExample
//
//  Created by Matija Kruljac on 3/30/18.
//  Copyright © 2018 Matija Kruljac. All rights reserved.
//

import Foundation
import SpriteKit

class Explosion: SKEmitterNode {
    
    init(particleColor: UIColor, position: CGPoint) {
        super.init()
        setup(with: particleColor, at: position)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(with particleColor: UIColor, at position: CGPoint) {
        let image = UIImage(named: "gray_catalog.png")!
        xScale = 2
        yScale = 1
        particleTexture = SKTexture(image: image)
        numParticlesToEmit = 270
        particleBirthRate = 270
        particleLifetime = 2
        emissionAngleRange = 360
        particleSpeed = 50
        particleSpeedRange = 360
        xAcceleration = 0
        yAcceleration = 0
        particleAlpha = 0.5
        particleAlphaRange = 0.2
        particleAlphaSpeed = -0.5
        particleScale = 0.4
        particleScaleRange = 0.3
        particleScaleSpeed = -0.5
        particleRotation = 0
        particleRotationRange = 0
        particleRotationSpeed = 0
        particleColorBlendFactor = 1
        particleColorBlendFactorRange = 0
        particleColorBlendFactorSpeed = 0
        particleBlendMode = .add
        self.position = position
        self.particleColor = particleColor
    }
}

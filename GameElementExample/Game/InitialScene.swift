//
//  InitialScene.swift
//  GameElementExample
//
//  Created by Matija Kruljac on 12/1/17.
//  Copyright © 2017 Matija Kruljac. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class InitialScene: SKScene {
    
    private unowned let viewController: GameViewController
    private let store: Store
    
    private let storeNameLabel = SKLabelNode()
    private let explosion = SKEmitterNode()
    private let playButton = SKSpriteNode(imageNamed: "play_game")
    
    init(size: CGSize, with store: Store, in viewController: GameViewController) {
        self.store = store
        self.viewController = viewController
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        setupInitialSettings()
        addStoreImage()
        addStoreNameLabel()
        addPlayButton()
    }
    
    private func setupInitialSettings() {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.zPosition = 0
        addChild(background)
    }
    
    private func addStoreImage() {
        let texture = SKTexture(image: store.image)
        let size = CGSize(width: 90, height: 90)
        let storeImage = SKSpriteNode(texture: texture, color: .clear, size: size)
        storeImage.position = CGPoint(x: frame.midX, y: frame.midY+150)
        storeImage.zPosition = 1
        addChild(storeImage)
    }
    
    private func addStoreNameLabel() {
        let position = CGPoint(x: frame.midX, y: frame.midY+50)
        storeNameLabel.text = store.name
        storeNameLabel.fontColor = .white
        storeNameLabel.fontName = "PingFangTC-Medium"
        storeNameLabel.fontSize = 35
        storeNameLabel.horizontalAlignmentMode = .center
        storeNameLabel.verticalAlignmentMode = .center
        storeNameLabel.zPosition = 1
        storeNameLabel.isHidden = true
        storeNameLabel.position = position
        addChild(storeNameLabel)
        animateStoreNameLabelExplosion()
    }
    
    private func animateStoreNameLabelExplosion() {
        addExplosionOnStoreNameLabel()
        let waitDuration: Double = Double(explosion.numParticlesToEmit) / Double(explosion.particleBirthRate)
        
        run(SKAction.wait(forDuration: waitDuration)) { [weak self] in
            self?.storeNameLabel.isHidden = false
            self?.explosion.removeFromParent()
        }
    }
    
    private func addExplosionOnStoreNameLabel() {
        let image = UIImage(named:"gray_catalog.png")!
        explosion.xScale = 2
        explosion.yScale = 1
        explosion.particleTexture = SKTexture(image: image)
        explosion.particleColor = store.backgroundColor
        explosion.numParticlesToEmit = 270
        explosion.particleBirthRate = 270
        explosion.particleLifetime = 2
        explosion.emissionAngleRange = 360
        explosion.particleSpeed = 50
        explosion.particleSpeedRange = 360
        explosion.xAcceleration = 0
        explosion.yAcceleration = 0
        explosion.particleAlpha = 0.5
        explosion.particleAlphaRange = 0.2
        explosion.particleAlphaSpeed = -0.5
        explosion.particleScale = 0.4
        explosion.particleScaleRange = 0.3
        explosion.particleScaleSpeed = -0.5
        explosion.particleRotation = 0
        explosion.particleRotationRange = 0
        explosion.particleRotationSpeed = 0
        explosion.particleColorBlendFactor = 1
        explosion.particleColorBlendFactorRange = 0
        explosion.particleColorBlendFactorSpeed = 0
        explosion.particleBlendMode = .add
        explosion.position = CGPoint(x: frame.midX, y: frame.midY+50)
        addChild(explosion)
    }
    
    private func addPlayButton() {
        playButton.position = CGPoint(x: frame.midX, y: frame.midY-50)
        playButton.zPosition = 1
        addChild(playButton)
        addPlayButtonAnimation()
    }
    
    private func addPlayButtonAnimation() {
        let pulseUp = SKAction.scale(to: 1.4, duration: 0.5)
        let pulseDown = SKAction.scale(to: 1.0, duration: 0.5)
        let pulse = SKAction.sequence([pulseUp, pulseDown])
        playButton.run(SKAction.repeatForever(pulse))
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        if !playButton.contains(touchLocation) { return }
        runGameScene()
    }
    
    private func runGameScene() {
        let transition = SKTransition.fade(withDuration: 1.0)
        let gameScene = GameScene(size: size, in: viewController, with: store)
        gameScene.scaleMode = .aspectFill
        view?.presentScene(gameScene, transition: transition)
    }
}

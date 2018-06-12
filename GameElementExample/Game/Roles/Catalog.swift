//
//  Catalog.swift
//  GameElementExample
//
//  Created by Matija Kruljac on 12/13/17.
//  Copyright © 2017 Matija Kruljac. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class Catalog: SKSpriteNode {
    
    private let skScene: SKScene
    private let store: Store
    private let catalogTexture: SKTexture

    private var durationValue: CGFloat {
        return CGFloat.random(min: 1.0, max: 2.0)
    }
    
    var scoreValue: Int {
        return determineScoreValue(for: durationValue)
    }
    
    init(skScene: SKScene, store: Store) {
        self.skScene = skScene
        self.store = store
        self.catalogTexture = SKTexture(image: store.image)
        let catalogSize = self.catalogTexture.size()
        super.init(texture: nil, color: store.backgroundColor, size: catalogSize)
        setupInitialSettings()
        setupCatalogImageNode()
        animate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupInitialSettings() {
        name = "catalog"
        physicsBody = SKPhysicsBody(rectangleOf: size)
        setupPhysicsBodyCommonProperties(for: self)
        zPosition = 0.5
        position = CGPoint(
            x: CGFloat.random(min: size.width, max: skScene.frame.maxX-size.width),
            y: skScene.frame.maxY)
    }
    
    private func setupCatalogImageNode() {
        let catalogImageSize = CGSize(width: self.catalogTexture.size().width-5,
                                      height: self.catalogTexture.size().height-5)
        let catalogImageNode = SKSpriteNode(texture: catalogTexture, size: catalogImageSize)
        setupPhysicsBodyCommonProperties(for: catalogImageNode)
        addChild(catalogImageNode)
    }
    
    private func setupPhysicsBodyCommonProperties(for node: SKSpriteNode) {
        node.physicsBody?.categoryBitMask = PhysicsCategory.catalog
        node.physicsBody?.contactTestBitMask = PhysicsCategory.cart
        node.physicsBody?.collisionBitMask = PhysicsCategory.cart
        node.physicsBody?.usesPreciseCollisionDetection = true
        node.physicsBody?.allowsRotation = true
    }
    
    private func animate() {
        let endPoint = CGPoint(x: position.x, y: -size.height)
        let duration = TimeInterval(durationValue)
        let moveAction = SKAction.move(to: endPoint, duration: duration)
        
        let left = arc4random() % 2
        let angle = left == 0 ? CGFloat(-90).degreesToRadians() : CGFloat(90).degreesToRadians()
        let rotate = SKAction.repeatForever(.rotate(byAngle: angle, duration: 0.2))
        
        run(rotate)
        run(moveAction) { [weak self] in
            self?.removeAllActions()
            self?.removeFromParent()
        }
    }
    
    private func determineScoreValue(for duration: CGFloat) -> Int {
        if duration <= 1.4 {
            return 1
        } else if duration < 1.7 {
            return 2
        } else if duration >= 1.7 {
            return 3
        }
        return 0
    }
}

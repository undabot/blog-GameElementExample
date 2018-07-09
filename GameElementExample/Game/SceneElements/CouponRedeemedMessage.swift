//
//  CouponRedeemedScene.swift
//  GameElementExample
//
//  Created by Matija Kruljac on 3/26/18.
//  Copyright © 2018 Matija Kruljac. All rights reserved.
//

import Foundation
import SpriteKit

class CouponRedeemedMessage: SKSpriteNode {
    
    private let store: Store
    
    init(size: CGSize, store: Store) {
        self.store = store
        super.init(texture: nil, color: .clear, size: size)
        setupInitialSettings()
        setupBackgroundNode(with: size)
        setupImage()
        setupTitleLabel()
        setupMessageLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupInitialSettings() {
        zPosition = 1
    }
    
    private func setupBackgroundNode(with size: CGSize) {
        let background = SKShapeNode(rect: CGRect(x: -size.width/2, y: -size.height/2, width: size.width, height: size.height), cornerRadius: 10)
        background.zPosition = 1
        background.fillColor = .white
        addChild(background)
    }
    
    private func setupImage() {
        let imageNode = SKSpriteNode(imageNamed: "redeem_coupon")
        imageNode.size = CGSize(width: 48, height: 48)
        imageNode.position = CGPoint(x: frame.midX, y: frame.midY+30)
        imageNode.zPosition = 2
        addChild(imageNode)
    }
    
    private func setupTitleLabel() {
        let titleLabel = SKLabelNode(text: "Congratulations!")
        titleLabel.fontName = "AvenirNext-Medium"
        titleLabel.fontSize = 15
        titleLabel.fontColor = .black
        titleLabel.horizontalAlignmentMode = .center
        titleLabel.verticalAlignmentMode = .center
        titleLabel.position = CGPoint(x: frame.midX, y: frame.midY-20)
        titleLabel.numberOfLines = 0
        titleLabel.zPosition = 2
        addChild(titleLabel)
    }
    
    private func setupMessageLabel() {
        let message = "\(store.name) coupon redeemed!"
        let messageLabel = SKLabelNode(text: message)
        messageLabel.fontName = "AvenirNext-Medium"
        messageLabel.fontSize = 15
        messageLabel.fontColor = .black
        messageLabel.horizontalAlignmentMode = .center
        messageLabel.verticalAlignmentMode = .center
        messageLabel.position = CGPoint(x: frame.midX, y: frame.midY-45)
        messageLabel.numberOfLines = 0
        messageLabel.zPosition = 2
        addChild(messageLabel)
    }
}

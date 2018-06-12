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
        super.init(texture: nil, color: store.backgroundColor, size: size)
        setupInitialSettings()
        setupTitleLabel()
        setupMessageLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupInitialSettings() {
        zPosition = 1
    }
    
    private func setupTitleLabel() {
        let titleLabel = SKLabelNode(text: "Congratulations!")
        titleLabel.fontName = "AvenirNext-Medium"
        titleLabel.fontSize = 15
        titleLabel.horizontalAlignmentMode = .center
        titleLabel.verticalAlignmentMode = .center
        titleLabel.position = CGPoint(x: frame.midX, y: frame.midY+15)
        titleLabel.numberOfLines = 0
        addChild(titleLabel)
    }
    
    private func setupMessageLabel() {
        let message = "\(store.name) coupon redeemed!"
        let messageLabel = SKLabelNode(text: message)
        messageLabel.fontName = "AvenirNext-Medium"
        messageLabel.fontSize = 15
        messageLabel.horizontalAlignmentMode = .center
        messageLabel.verticalAlignmentMode = .center
        messageLabel.position = CGPoint(x: frame.midX, y: frame.midY-15)
        messageLabel.numberOfLines = 0
        addChild(messageLabel)
    }
}

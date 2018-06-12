//
//  TimesUpScene.swift
//  GameElementExample
//
//  Created by Matija Kruljac on 11/30/17.
//  Copyright © 2017 Matija Kruljac. All rights reserved.
//

import Foundation
import SpriteKit

class TimesUpScene: SKScene {
    
    private unowned let viewController: GameViewController
    private let store: Store
    
    private let repeatButton = SKSpriteNode(imageNamed: "repeat")
    private var score: Int = 0
    
    init(with size: CGSize, andWith score: Int, in viewController: GameViewController, with store: Store) {
        self.score = score
        self.viewController = viewController
        self.store = store
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        setupInitialSettings()
        addTitleLabel()
        addScoreLabel()
        addRepeatButton()
    }
    
    private func setupInitialSettings() {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.zPosition = 0
        addChild(background)
    }
    
    private func addTitleLabel() {
        let titleLabel = SKLabelNode(fontNamed: "AvenirNext-Medium")
        titleLabel.text = "Time is up!"
        titleLabel.fontSize = 35
        titleLabel.position = CGPoint(x: frame.midX, y: frame.midY + 80)
        titleLabel.zPosition = 1
        addChild(titleLabel)
    }
    
    private func addScoreLabel() {
        let scoreLabel = SKLabelNode(fontNamed: "AvenirNext-Medium")
        scoreLabel.text = "\(score) points collected."
        scoreLabel.fontSize = 25
        scoreLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        scoreLabel.zPosition = 1
        addChild(scoreLabel)
    }
    
    private func addRepeatButton() {
        repeatButton.position = CGPoint(x: frame.midX, y: frame.midY - 80)
        repeatButton.zPosition = 1
        addChild(repeatButton)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        if !repeatButton.contains(touchLocation) {
            return
        }
        runGameScene()
    }
    
    private func runGameScene() {
        run(SKAction.sequence([
            SKAction.wait(forDuration: 0.5),
            SKAction.run { [weak self] in
                self?.presentGameScene()
            }])
        )
    }
    
    private func presentGameScene() {
        let transition = SKTransition.fade(withDuration: 1.0)
        let gameScene = GameScene(size: size, in: viewController, with: store)
        gameScene.scaleMode = .aspectFill
        view?.presentScene(gameScene, transition: transition)
    }
}

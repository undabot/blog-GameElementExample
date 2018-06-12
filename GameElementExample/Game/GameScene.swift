//
//  GameScene.swift
//  GameElementExample
//
//  Created by Matija Kruljac on 11/29/17.
//  Copyright © 2017 Matija Kruljac. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class GameScene: SKScene {

    fileprivate unowned let viewController: GameViewController
    fileprivate let store: Store
    
    private var lastSpawnTimeInterval: TimeInterval = 0
    private var lastUpdateTimeInterval: TimeInterval = 0
    private let lastSpawnTimeIntervalCeiling: TimeInterval = 0.75
    
    private var score: Int = 0
    private var time: Int = 20
    
    private let cartOffsetOnScreenEdges: CGFloat = 15.0
    private let maximalGeneratedNumberOfCatalogs: Int = 3
    
    private let scoreLabel = SKLabelNode()
    private let timerLabel = SKLabelNode()
    
    private let continuePlayingTexture = SKTexture(imageNamed: "play_game")
    private let pauseTexture = SKTexture(imageNamed: "pause")
    
    private lazy var pausePlayButton = SKSpriteNode(texture: self.pauseTexture)
    private let cart = SKSpriteNode(imageNamed: "cart")
    private lazy var catalogMainTexture = SKTexture(image: self.store.image)
    
    private var couponRedeemedMessage: CouponRedeemedMessage?
    
    init(size: CGSize, in viewController: GameViewController, with store: Store) {
        self.viewController = viewController
        self.store = store
        self.score = store.couponScore
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        setupInitialSettings()
        addScoreLabel()
        addTimerLabel()
        addPauseButton()
        addCart()
        startTimer()
    }
    
    private func setupInitialSettings() {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.zPosition = 0
        addChild(background)
        physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
        physicsWorld.contactDelegate = self
    }
    
    private func addScoreLabel() {
        scoreLabel.fontName = "AvenirNext-Medium"
        scoreLabel.text = "Score: \(score)/\(store.maxCuponScore)"
        scoreLabel.fontSize = 20
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.verticalAlignmentMode = .top
        scoreLabel.position = CGPoint(x: 10, y: frame.maxY - 100)
        scoreLabel.zPosition = 1
        addChild(scoreLabel)
    }
    
    private func addTimerLabel() {
        timerLabel.fontName = "AvenirNext-Medium"
        timerLabel.text = "Time: 00:00"
        timerLabel.fontSize = 20
        timerLabel.horizontalAlignmentMode = .left
        timerLabel.verticalAlignmentMode = .top
        timerLabel.position = CGPoint(x: 10, y: frame.maxY - 140)
        timerLabel.zPosition = 1
        addChild(timerLabel)
    }
    
    private func addPauseButton() {
        pausePlayButton.position = CGPoint(x: frame.size.width - 35, y: frame.maxY - 110)
        pausePlayButton.size = CGSize(width: 35, height: 35)
        pausePlayButton.zPosition = 1
        addChild(pausePlayButton)
    }
    
    private func startTimer() {
        let actionWait = SKAction.wait(forDuration: 1.0)
        let actionRun = SKAction.run { [weak self] in
            self?.handleTimerTick()
        }
        timerLabel.run(SKAction.repeatForever(SKAction.sequence([actionWait, actionRun])))
    }
    
    private func handleTimerTick() {
        if time > 0 {
            time -= 1
            timerLabel.text = "Time: 00:\(time)"
        } else {
            removeCatalogNodes()
            updateCurrentStore()
            runTimesUpScene()
            timerLabel.removeAllActions()
        }
    }
    
    private func updateCurrentStore() {
        updateCurrentStoreScore()
        viewController.handleGameTimesUp(for: store)
    }
    
    private func updateCurrentStoreScore() {
        store.couponScore = score
    }
    
    private func removeCatalogNodes() {
        children.forEach {
            guard let node = $0 as? SKSpriteNode,
                node.name == "catalog"
                else {
                    return
            }
            node.removeFromParent()
        }
    }
    
    private func runTimesUpScene() {
        run(SKAction.sequence([
            SKAction.wait(forDuration: 2.0),
            SKAction.run { [weak self] in
                self?.presentTimesUpScene()
            }]
        ))
    }
    
    private func presentTimesUpScene() {
        let transition = SKTransition.fade(withDuration: 1.0)
        let timesUpScene = TimesUpScene(with: size, andWith: score, in: viewController, with: store)
        view?.presentScene(timesUpScene, transition: transition)
    }
    
    private func addCart() {
        cart.name = "cart"
        cart.position = CGPoint(x: frame.width/2, y: 100)
        cart.physicsBody = SKPhysicsBody(rectangleOf: cart.size)
        cart.physicsBody?.categoryBitMask = PhysicsCategory.cart
        cart.physicsBody?.contactTestBitMask = PhysicsCategory.catalog
        cart.physicsBody?.collisionBitMask = PhysicsCategory.catalog
        cart.physicsBody?.usesPreciseCollisionDetection = true
        cart.physicsBody?.isDynamic = false
        cart.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        cart.zPosition = 1
        addChild(cart)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        touches.forEach { [weak self] touch in
            guard let welf = self else {
                return
            }
            let location = touch.location(in: welf)
            let node: SKNode = atPoint(location)
            if node.name != "cart" {
                return
            }
            cart.removeAction(forKey: "repeatedCartMovementAction")
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        cart.removeAction(forKey: "repeatedCartMovementAction")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        if pausePlayButton.contains(touchLocation) {
            handlePausePlayButtonTap()
            return
        }
        if let couponRedeemedMessage = couponRedeemedMessage,
            couponRedeemedMessage.contains(touchLocation) {
            removeCatalogNodes()
            viewController.popFromNavigationStack()
            return
        }
        handleCartMovement(with: touches)
    }
    
    private func handlePausePlayButtonTap() {
        if !isGamePaused {
            changePausePlayButton(texture: continuePlayingTexture, completion: { [weak self] in
                self?.pauseTheGame()
            })
        } else {
            unpauseTheGame()
            changePausePlayButton(texture: pauseTexture)
        }
    }
    
    private func changePausePlayButton(texture: SKTexture, completion: (() -> Void)? = nil) {
        let changeTextureAction = SKAction.animate(with: [texture], timePerFrame: 0.0)
        pausePlayButton.run(changeTextureAction) {
            completion?()
        }
    }
    
    private func handleCartMovement(with touches: Set<UITouch>) {
        touches.forEach { touch in
            let runAction = SKAction.run { [weak self] in
                self?.moveCartIfNeeded(on: touch)
            }
            repeatCartMovement(with: runAction)
        }
    }
    
    private func moveCartIfNeeded(on touch: UITouch) {
        let location = touch.location(in: self)
        let xValue = calculateNewXValue(from: location)
        if xValue < cart.size.width/2 || xValue > frame.maxX-cart.size.width/2 { return }
        let newLocation = CGPoint(x: xValue, y: cart.position.y)
        let moveAction = SKAction.move(to: newLocation, duration: 0.025)
        cart.run(moveAction)
    }
    
    private func calculateNewXValue(from location: CGPoint) -> CGFloat {
        if location.x > frame.midX {
            return cart.position.x+cartOffsetOnScreenEdges
        }
        return cart.position.x-cartOffsetOnScreenEdges
    }
    
    private func repeatCartMovement(with runAction: SKAction) {
        cart.run(
            .repeatForever(
                .sequence([runAction, .wait(forDuration: 0.001)])),
            withKey: "repeatedCartMovementAction")
    }
    
    private func updateWithTimeSinceLastUpdate(timeSinceLast: CFTimeInterval) {
        lastSpawnTimeInterval = timeSinceLast + lastSpawnTimeInterval
        if lastSpawnTimeInterval < lastSpawnTimeIntervalCeiling {
            return
        }
        lastSpawnTimeInterval = 0
        addCatalogsIfNeeded()
    }
    
    private func addCatalogsIfNeeded() {
        if time == 0 {
            return
        }
        for _ in 0...random(min: 0, max: maximalGeneratedNumberOfCatalogs) {
            addCatalog()
        }
    }
    
    private func addCatalog() {
        let catalog = Catalog(skScene: self, store: store)
        catalog.name = "catalog"
        addChild(catalog)
    }
    
    private func random(min: Int, max: Int) -> Int {
        guard min < max else {
            return min
        }
        return Int(arc4random_uniform(UInt32(1 + max - min))) + min
    }
    
    override func update(_ currentTime: CFTimeInterval) {
        var timeSinceLast = currentTime - lastUpdateTimeInterval
        lastUpdateTimeInterval = currentTime
        if timeSinceLast > 1.0 {
            timeSinceLast = 1.0 / 60.0
            lastUpdateTimeInterval = currentTime
        }
        updateWithTimeSinceLastUpdate(timeSinceLast: timeSinceLast)
    }
}

extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        handleCartIfNeeded(in: contact)
        handleCatalogIfNeeded(in: contact)
    }
    
    private func handleCartIfNeeded(in contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask != PhysicsCategory.cart {
            return
        }
        if contact.bodyA.node as? SKSpriteNode != nil {
            pulse(cart: cart)
        }
    }
    
    private func pulse(cart: SKSpriteNode) {
        if cart.action(forKey: "cartPulse") != nil {
            cart.removeAction(forKey: "cartPulse")
        }
        let pulseUp = SKAction.scale(to: 1.2, duration: 0.1)
        let pulseDown = SKAction.scale(to: 1.0, duration: 0.1)
        let pulse = SKAction.sequence([pulseUp, pulseDown])
        cart.run(pulse, withKey: "cartPulse")
    }
    
    private func handleCatalogIfNeeded(in contact: SKPhysicsContact) {
        if contact.bodyB.categoryBitMask != PhysicsCategory.catalog {
            return
        }
        guard let catalog = contact.bodyB.node as? Catalog else {
            return
        }
        let cartFrame = CGRect(x: cart.frame.origin.x + 20,
                               y: cart.frame.origin.y,
                               width: cart.frame.size.width - 40,
                               height: cart.frame.size.height)
        if !cartFrame.intersects(catalog.frame) {
            return
        }
        updateScore(for: catalog.scoreValue)
        addIncrementLabel(for: catalog.scoreValue)
        run(SKAction.playSoundFileNamed("catch.mp3", waitForCompletion: false))
        catalog.removeFromParent()
        handleCouponRedemptionIfNeeded()
    }
    
    private func updateScore(for value: Int) {
        score += value
        scoreLabel.text = "Score: \(score)/\(store.maxCuponScore)"
    }
    
    private func handleCouponRedemptionIfNeeded() {
        if score >= store.maxCuponScore {
            presentCouponRedeemedSceneIfNeeded()
            handleSceneWhenCouponIsRedeemed()
        }
    }
    
    private func presentCouponRedeemedSceneIfNeeded() {
        let size = CGSize(width: frame.size.width - 50, height: 150)
        couponRedeemedMessage = CouponRedeemedMessage(size: size, store: store)
        guard let couponRedeemedMessage = couponRedeemedMessage else {
            return
        }
        couponRedeemedMessage.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(couponRedeemedMessage)
    }
    
    private func handleSceneWhenCouponIsRedeemed() {
        scoreLabel.text = "Score: \(store.maxCuponScore)/\(store.maxCuponScore)"
        pausePlayButton.isHidden = true
        pauseTheGame()
        updateCurrentStore()
    }
    
    private func addIncrementLabel(for value: Int) {
        let incrementLabel = IncrementLabel(with: value, for: cart.frame)
        addChild(incrementLabel)
        incrementLabel.startAnimation()
    }
}

struct PhysicsCategory {
    
    static let cart: UInt32 = 0x1 << 0
    static let catalog: UInt32 = 0x1 << 1
}

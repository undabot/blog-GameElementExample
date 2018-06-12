//
//  GameViewController.swift
//  GameElementExample
//
//  Created by Matija Kruljac on 12/13/17.
//  Copyright © 2017 Matija Kruljac. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    private let gameTitle = "Play to Earn"
    
    weak var delegate: GameViewControllerDelegate?
    
    private let store: Store
    
    init(with store: Store) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup(navigationBarTitle: gameTitle, tabBarItemTitle: TabBarItems.game.name)
        setupTabBarItem(image: TabBarItems.game.selectedImage)
        setupBackgroundColor()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupScene()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setupTabBarItem(image: TabBarItems.stores.selectedImage)
    }
    
    func handleGameTimesUp(for store: Store) {
        delegate?.scoreValueChanged(for: store)
    }
    
    func popFromNavigationStack() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupTabBarItem(image: UIImage) {
        guard let tabBarItem = tabBarController?.tabBar.items?.first else {
            return
        }
        tabBarItem.selectedImage = image
    }
    
    private func setupScene() {
        view = SKView(frame: CGRect(
            x: 0, y: 0,
            width: view.frame.size.width,
            height: view.frame.size.height))
        let scene = InitialScene(size: view.bounds.size, with: store, in: self)
        let skView = getConfiguredSKView()
        scene.scaleMode = .resizeFill
        skView?.presentScene(scene)
    }
    
    private func getConfiguredSKView() -> SKView? {
        guard let skView = view as? SKView else {
            return nil
        }
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        return skView
    }
}

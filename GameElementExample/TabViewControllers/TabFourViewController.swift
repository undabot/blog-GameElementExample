//
//  TabFourViewController.swift
//  GameElementExample
//
//  Created by Matija Kruljac on 11/29/17.
//  Copyright © 2017 Matija Kruljac. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class TabFourViewController: UIViewController {
    
    private var store: Store?
    
    init(with store: Store) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupTitle(inNavigationBar: "Game")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitle(inNavigationBar: "Play to Earn", inTabBarItem: "Game")
        setupBackgroundColor()
    }
}

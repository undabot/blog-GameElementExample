//
//  CatalogsViewController.swift
//  GameElementExample
//
//  Created by Matija Kruljac on 11/29/17.
//  Copyright © 2017 Matija Kruljac. All rights reserved.
//

import Foundation
import UIKit

class CatalogsViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup(navigationBarTitle: TabBarItems.catalogs.name)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundColor()
    }
}

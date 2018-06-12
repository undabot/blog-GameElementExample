//
//  UIViewControllerExtensions.swift
//  GameElementExample
//
//  Created by Matija Kruljac on 11/29/17.
//  Copyright © 2017 Matija Kruljac. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func setup(navigationBarTitle: String? = nil, tabBarItemTitle: String? = nil) {
        if let navigationBarTitle = navigationBarTitle {
            title = navigationBarTitle
        }
        if let tabBarItemTitle = tabBarItemTitle {
            navigationController?.tabBarItem.title = tabBarItemTitle
        }
    }
    
    func setupBackgroundColor(_ color: UIColor? = .white) {
        view.backgroundColor = color
    }
}

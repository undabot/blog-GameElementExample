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
    
    func setupTitle(inNavigationBar navigationBarTitle: String? = nil, inTabBarItem tabBarItemTitle: String? = nil) {
        if let navigationBarTitle = navigationBarTitle {
            title = navigationBarTitle
        }
        if let tabBarItemTitle = tabBarItemTitle {
            navigationController?.tabBarItem.title = tabBarItemTitle
        }
    }
    
    func setupBackgroundColor(_ color: UIColor? = nil) {
        guard let color = color else {
            view.backgroundColor = .white
            return
        }
        view.backgroundColor = color
    }
}

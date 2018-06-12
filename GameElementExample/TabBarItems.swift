//
//  TabBarItems.swift
//  GameElementExample
//
//  Created by Matija Kruljac on 5/22/18.
//  Copyright © 2018 Matija Kruljac. All rights reserved.
//

import Foundation
import UIKit

enum TabBarItems: String {
    
    case stores
    case profile
    case catalogs
    case game
    
    var name: String {
        switch self {
        case .stores:
            return "Stores"
        case .profile:
            return "Profile"
        case .catalogs:
            return "Catalogs"
        case .game:
            return "Game"
        }
    }
    
    var unselectedImage: UIImage {
        switch self {
        case .stores:
            return #imageLiteral(resourceName: "stores_inactive")
        case .profile:
            return #imageLiteral(resourceName: "profile_inactive")
        case .catalogs:
            return #imageLiteral(resourceName: "catalogs_inactive")
        case .game:
            return #imageLiteral(resourceName: "game_inactive")
        }
    }
    
    var selectedImage: UIImage {
        switch self {
        case .stores:
            return #imageLiteral(resourceName: "stores_active")
        case .profile:
            return #imageLiteral(resourceName: "profile_active")
        case .catalogs:
            return #imageLiteral(resourceName: "catalogs_active")
        case .game:
            return #imageLiteral(resourceName: "game_active")
        }
    }
}

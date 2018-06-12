//
//  ViewController.swift
//  GameElementExample
//
//  Created by Matija Kruljac on 11/29/17.
//  Copyright © 2017 Matija Kruljac. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    private let storesViewController = StoresViewController()
    private let profileViewController = ProfileViewController()
    private let catalogsViewController = CatalogsViewController()
    
    private lazy var storesTabNavigationController = UINavigationController(rootViewController: self.storesViewController)
    private lazy var profileTabNavigationController = UINavigationController(rootViewController: self.profileViewController)
    private lazy var catalogsTabNavigationController = UINavigationController(rootViewController: self.catalogsViewController)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarTitleAppearance()
        setupStoresTab()
        setupProfileTab()
        setupCatalogsTab()
        addTabs()
    }
    
    private func setupTabBarTitleAppearance() {
        let selectedColor   = UIColor(red: 0.98, green: 0.11, blue: 0.25, alpha: 1)
        let unselectedColor = UIColor(red: 0.16, green: 0.17, blue: 0.18, alpha: 1)
        
        UITabBarItem
            .appearance()
            .setTitleTextAttributes([NSAttributedStringKey.foregroundColor: unselectedColor],
                                    for: .normal)
        UITabBarItem
            .appearance()
            .setTitleTextAttributes([NSAttributedStringKey.foregroundColor: selectedColor],
                                    for: .selected)
    }
    
    private func setupStoresTab() {
        let firstTabBarItem = UITabBarItem(title: TabBarItems.stores.name,
                                           image: TabBarItems.stores.unselectedImage,
                                           selectedImage: TabBarItems.stores.selectedImage)
        storesViewController.tabBarItem = firstTabBarItem
    }
    
    private func setupProfileTab() {
        let secondTabBarItem = UITabBarItem(title: TabBarItems.profile.name,
                                            image: TabBarItems.profile.unselectedImage,
                                            selectedImage: TabBarItems.profile.selectedImage)
        profileViewController.tabBarItem = secondTabBarItem
    }
    
    private func setupCatalogsTab() {
        let thirdTabBarItem = UITabBarItem(title: TabBarItems.catalogs.name,
                                           image: TabBarItems.catalogs.unselectedImage,
                                           selectedImage: TabBarItems.catalogs.selectedImage)
        catalogsViewController.tabBarItem = thirdTabBarItem
    }
    
    private func addTabs() {
        viewControllers = [storesTabNavigationController,
                           profileTabNavigationController,
                           catalogsTabNavigationController]
    }
}

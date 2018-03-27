//
//  ViewController.swift
//  GameElementExample
//
//  Created by Matija Kruljac on 11/29/17.
//  Copyright © 2017 Matija Kruljac. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    private let tabOne = TabOneViewController()
    private let tabTwo = TabTwoViewController()
    private let tabThree = TabThreeViewController()
    private let tabFour = TabFourViewController()
    
    private let tabOneNavigationController: UINavigationController
    private let tabTwoNavigationController: UINavigationController
    private let tabThreeNavigationController: UINavigationController
    private let tabFourNavigationController: UINavigationController
    
    init() {
        tabOneNavigationController = UINavigationController(rootViewController: self.tabOne)
        tabTwoNavigationController = UINavigationController(rootViewController: self.tabTwo)
        tabThreeNavigationController = UINavigationController(rootViewController: self.tabThree)
        tabFourNavigationController = UINavigationController(rootViewController: self.tabFour)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarTitleAppearance()
        setupTabOne()
        setupTabTwo()
        setupTabThree()
        setupTabFour()
        addTabs()
    }
    
    private func setupTabBarTitleAppearance() {
        let selectedColor   = UIColor(red:0.98, green:0.11, blue:0.25, alpha:1)
        let unselectedColor = UIColor(red:0.16, green:0.17, blue:0.18, alpha:1)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: unselectedColor], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: selectedColor], for: .selected)
    }
    
    private func setupTabOne() {
        let tabOneBarItem = UITabBarItem(title: "Stores", image: #imageLiteral(resourceName: "stores_inactive"), selectedImage: #imageLiteral(resourceName: "stores_active"))
        tabOne.tabBarItem = tabOneBarItem
    }
    
    private func setupTabTwo() {
        let tabTwoBarItem = UITabBarItem(title: "Profile", image: #imageLiteral(resourceName: "profile_inactive"), selectedImage: #imageLiteral(resourceName: "profile_active"))
        tabTwo.tabBarItem = tabTwoBarItem
    }
    
    private func setupTabThree() {
        let tabThreeBarItem = UITabBarItem(title: "Catalogs", image: #imageLiteral(resourceName: "catalogs_inactive"), selectedImage: #imageLiteral(resourceName: "catalogs_active"))
        tabThree.tabBarItem = tabThreeBarItem
    }
    
    private func setupTabFour() {
        let tabFourBarItem = UITabBarItem(title: "Game", image: #imageLiteral(resourceName: "game_inactive"), selectedImage: #imageLiteral(resourceName: "game_active"))
        tabFour.tabBarItem = tabFourBarItem
    }
    
    private func addTabs() {
        viewControllers = [tabOneNavigationController, tabTwoNavigationController,
                           tabThreeNavigationController, /* tabFourNavigationController */ ]
    }
}

//
//  ProfileViewController.swift
//  GameElementExample
//
//  Created by Matija Kruljac on 11/29/17.
//  Copyright © 2017 Matija Kruljac. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    
    private let userImageView = UIImageView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup(navigationBarTitle: TabBarItems.profile.name)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundColor()
        setupUserImageView()
    }
    
    private func setupUserImageView() {
        view.addSubview(userImageView)
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            userImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userImageView.widthAnchor.constraint(equalToConstant: 100),
            userImageView.heightAnchor.constraint(equalToConstant: 100)
            ])
        userImageView.image = #imageLiteral(resourceName: "user")
    }
}

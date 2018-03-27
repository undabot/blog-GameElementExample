//
//  TabOneViewController.swift
//  GameElementExample
//
//  Created by Matija Kruljac on 11/29/17.
//  Copyright © 2017 Matija Kruljac. All rights reserved.
//

import Foundation
import UIKit

class TabOneViewController: UIViewController {
    
    private let tableView = UITableView()
    
    private var data = [Store]()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupTitle(inNavigationBar: "Stores")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundColor()
        setupTableView()
        data = Store.generateData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTitle(inTabBarItem: "Stores")
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        addTableViewConstraints()
        tableView.register(StoreCell.self, forCellReuseIdentifier: String(describing: StoreCell.self))
    }
    
    private func addTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
    fileprivate func pushGameViewController(with store: Store) {
        let viewController = GameViewController(with: store)
        viewController.delegate = self
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension TabOneViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: StoreCell.self), for: indexPath) as? StoreCell else { return UITableViewCell() }
        cell.setup(with: data[indexPath.row])
        return cell
    }
}

extension TabOneViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let store = data[indexPath.row]
        if store.cuponScore < store.maxCuponScore {
            pushGameViewController(with: store)
        } else {
            showAlertView(for: store.name)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func showAlertView(for storeName: String) {
        let alert = UIAlertController(
            title: "Unlocked",
            message: "You've unlocked coupon for \(storeName)!",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension TabOneViewController: GameViewControllerDelegate {
    
    func scoreValueChanged(for store: Store) {
        data.forEach {
            if $0.identifier == store.identifier {
                $0.cuponScore = store.cuponScore
            }
        }
        tableView.reloadData()
    }
}

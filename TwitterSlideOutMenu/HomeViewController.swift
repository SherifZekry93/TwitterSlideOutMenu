//
//  ViewController.swift
//  TwitterSlideOutMenu
//
//  Created by Sherif  Wagih on 12/24/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController,UIGestureRecognizerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    func setupViews()
    {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(handleOpenMenu))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(handleOpenMenu))
    }
    @objc func handleOpenMenu()
    {
        let baseController = (UIApplication.shared.delegate  as! AppDelegate).rootViewController()
        baseController.openMenu()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "handleToggleMenu")
        cell.textLabel?.text = "Row \(indexPath.row)"
        return cell
    }
    
}

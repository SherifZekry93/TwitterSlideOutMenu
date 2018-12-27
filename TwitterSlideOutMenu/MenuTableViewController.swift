//
//  MenuTableViewController.swift
//  TwitterSlideOutMenu
//
//  Created by Sherif  Wagih on 12/24/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
extension MenuTableViewController
{
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let root = UIApplication.shared.keyWindow!.rootViewController as! BaseSlidingController
        root.didSelectMenuItem(indexPath: indexPath)
    }
}
class MenuTableViewController: UITableViewController {
    let menuItems:[MenuItem] = [
        MenuItem(icon: #imageLiteral(resourceName: "account"),title: "Profile"),
        MenuItem(icon:#imageLiteral(resourceName: "trending"),title:"Trending"),
        MenuItem(icon:#imageLiteral(resourceName: "subscriptions"),title:"Videoss")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        tableView.separatorStyle = .none
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let purpleView = CustomMenuHeaderView()
        return purpleView
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MenuItemCell(style: .default, reuseIdentifier: "cellID")
        let menuItem = menuItems[indexPath.row]
        cell.titleLabel.text = menuItem.title
        cell.iconImage.image = menuItem.icon.withRenderingMode(.alwaysTemplate)
        cell.imageView?.tintColor = .lightGray
        return cell
    }
}

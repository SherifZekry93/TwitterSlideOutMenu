//
//  ChatRoomMenu.swift
//  TwitterSlideOutMenu
//
//  Created by Sherif  Wagih on 12/27/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
class ChatRoomMenu: UITableViewController {
    let elements = [
        ["Sherif","Wagih"],
        ["Bolas"],
        ["Zekry","Nakhla"]
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor  = #colorLiteral(red: 0.3058823529, green: 0.2196078431, blue: 0.2862745098, alpha: 1)
        tableView.separatorStyle = .none
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Unreads" : section == 1 ? "Channels" : "Direct Message"
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements[section].count
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = ChatRoomMenuCell(style: .default, reuseIdentifier: "")
        cell.backgroundColor = .clear
        cell.textLabel?.text = "#\(elements[indexPath.section][indexPath.row])";
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        cell.textLabel?.textColor = .white
        return cell
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return elements.count
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = CustomHeaderLabel()
        label.text =  section == 0 ? "Unreads" : section == 1 ? "Channels" : "Direct Message"
        label.textColor = .gray
        return label
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 65
    }
}

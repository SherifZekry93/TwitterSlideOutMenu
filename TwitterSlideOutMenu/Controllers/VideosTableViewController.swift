//
//  VideosTableViewController.swift
//  TwitterSlideOutMenu
//
//  Created by Sherif  Wagih on 12/26/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit

class VideosTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ay7aga")
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}

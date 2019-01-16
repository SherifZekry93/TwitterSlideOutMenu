//
//  ChatRoomMenuCell.swift
//  TwitterSlideOutMenu
//
//  Created by Sherif  Wagih on 12/27/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
class ChatRoomMenuCell: UITableViewCell {
    let bgView:UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 0.2449403405, green: 0.5266470909, blue: 0.4076916575, alpha: 1)
        v.layer.cornerRadius = 5
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(bgView)
        bgView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        bgView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        bgView.leadingAnchor.constraint(equalTo: leadingAnchor,constant:10).isActive = true
        
        bgView.trailingAnchor.constraint(equalTo: trailingAnchor,constant:-10).isActive = true
        sendSubviewToBack(bgView)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        bgView.isHidden = !selected
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

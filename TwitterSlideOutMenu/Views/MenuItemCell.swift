//
//  MenuItemCell.swift
//  TwitterSlideOutMenu
//
//  Created by Sherif  Wagih on 12/26/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
class MenuItemCell: UITableViewCell {
    let iconImage:UIImageView  = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .lightGray
        return iv
    }()
    let titleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    lazy var stackView:UIStackView = {
        let stack = UIStackView(arrangedSubviews: [iconImage,titleLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 10
        stack.alignment = .center
        stack.distribution = .fill
        return stack
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style , reuseIdentifier: reuseIdentifier)
        //backgroundColor = .orange
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor,constant:10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor,constant:-10),
            iconImage.widthAnchor.constraint(equalToConstant: 50),
            iconImage.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

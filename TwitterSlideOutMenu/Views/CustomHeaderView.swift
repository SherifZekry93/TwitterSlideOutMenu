//
//  CustomHeaderView.swift
//  TwitterSlideOutMenu
//
//  Created by Sherif  Wagih on 12/25/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
class CustomMenuHeaderView: UIView {
    let nameLabel:UILabel  = {
        let label = UILabel()
        label.text = "Sherif Zekry"
        label.font = UIFont(name: "Avenir Next", size: 25)
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    let userNameLabel:UILabel = {
        let label = UILabel()
        label.text = "SherifZekry93"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    let profileImageView:UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .yellow
        image.layer.cornerRadius = 25
        image.clipsToBounds = true
        return image
    }()
    
    let infoLabel:UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "42", attributes: [.font:UIFont.boldSystemFont(ofSize: 18)])
        attributedText.append(NSAttributedString(string: "Following", attributes: [.font:UIFont.systemFont(ofSize: 15)]))
         attributedText.append(NSAttributedString(string: " 8900", attributes: [.font:UIFont.boldSystemFont(ofSize: 18)]))
        attributedText.append(NSAttributedString(string: "Followers", attributes: [.font:UIFont.systemFont(ofSize: 15)]))
        label.attributedText = attributedText
        return label
    }()
    
    lazy var containerStack:UIStackView = {
       let stack = UIStackView(arrangedSubviews: [profileImageView,nameLabel,userNameLabel,UIView(),UIView(),UIView(),infoLabel,UIView()])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .leading
        stack.spacing = 7
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupViews()
    }
    func setupViews()
    {
        addSubview(containerStack)
        containerStack.topAnchor.constraint(equalTo: topAnchor,constant:10).isActive = true
        containerStack.leadingAnchor.constraint(equalTo: leadingAnchor,constant:10).isActive = true
        containerStack.trailingAnchor.constraint(equalTo: trailingAnchor,constant:-10).isActive = true
        containerStack.bottomAnchor.constraint(equalTo: bottomAnchor,constant:-10).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

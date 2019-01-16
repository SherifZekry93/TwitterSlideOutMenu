//
//  SettingsController.swift
//  TwitterSlideOutMenu
//
//  Created by Sherif  Wagih on 12/26/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
class TrendingController<TypeView:TrendingView>: UIViewController {
    let newView:UIView = {
        let view = TypeView()
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = newView
        navigationItem.title = "Trending"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
class TrendingView:UIView
{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews()
    {
        let label = UILabel()
        label.text  = "Trending"
        label.frame = frame
        label.textAlignment = .center
        label.textColor = .black
        addSubview(label)
        backgroundColor = .white
    }
}

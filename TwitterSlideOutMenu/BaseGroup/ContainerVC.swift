//
//  ContainerVC.swift
//  TwitterSlideOutMenu
//
//  Created by Sherif  Wagih on 12/25/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
protocol sideMenuDelegate
{
    func selectAnItem(indexPath:IndexPath)
}
class BaseSlidingController: UIViewController,sideMenuDelegate {
    var redViewLeadingConstraint:NSLayoutConstraint!
    var redViewTrailingConstraint:NSLayoutConstraint!
    var menuWidth:CGFloat = 300
    var isMenuOpen:Bool = false
    let rightView:UIView =  {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    let leftView:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var darkCoverView : UIView = {
        let v = UIView()
        v.backgroundColor = .black
        v.alpha = 0
        v.backgroundColor = UIColor(white: 0, alpha: 0.8)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissUsingDarkCoverView)))
        return v
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupViews()
        view.backgroundColor = .white
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(panGesture)
    }
    
    @objc func handlePan(gesture:UIPanGestureRecognizer)
    {
        let translation = gesture.translation(in: view)
        var x  = min(menuWidth, translation.x)
        if isMenuOpen
        {
            x  += menuWidth
        }
        x = max(0,x)
        let alpha = x / menuWidth
        darkCoverView.alpha = alpha
        redViewLeadingConstraint.constant = x
        redViewTrailingConstraint.constant = x
        if gesture.state == .ended
        {
            handleEnded(gesture:gesture)
        }
    }
    private func setupViews() {
        view.addSubview(rightView)
        view.addSubview(leftView)
        redViewLeadingConstraint =  rightView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant:0);
        redViewTrailingConstraint =
        rightView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        NSLayoutConstraint.activate([
            rightView.topAnchor.constraint(equalTo: view.topAnchor),
            rightView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            redViewLeadingConstraint,
            redViewTrailingConstraint,
            leftView.topAnchor.constraint(equalTo: view.topAnchor),
            leftView.trailingAnchor.constraint(equalTo: rightView.leadingAnchor),
            leftView.widthAnchor.constraint(equalToConstant: menuWidth),
            leftView.heightAnchor.constraint(equalTo: view.heightAnchor)
            ])
        setupViewControllers()
    }
    fileprivate func setupViewControllers()
    {
        let homeView = rightViewController.view!
        homeView.translatesAutoresizingMaskIntoConstraints = false
        rightView.addSubview(homeView)
        addChild(rightViewController)
        rightView.addSubview(darkCoverView)
        NSLayoutConstraint.activate([
            homeView.topAnchor.constraint(equalTo: rightView.topAnchor),
            homeView.bottomAnchor.constraint(equalTo: rightView.bottomAnchor),
            homeView.trailingAnchor.constraint(equalTo: rightView.trailingAnchor),
            homeView.leadingAnchor.constraint(equalTo: rightView.leadingAnchor),
            darkCoverView.topAnchor.constraint(equalTo: rightView.topAnchor),
            darkCoverView.bottomAnchor.constraint(equalTo: rightView.bottomAnchor),
            darkCoverView.trailingAnchor.constraint(equalTo: rightView.trailingAnchor),
            darkCoverView.leadingAnchor.constraint(equalTo: rightView.leadingAnchor)
            ])
        let menu = MenuTableViewController()
        menu.delegate = self
        let menuView = menu.view!
        menuView.translatesAutoresizingMaskIntoConstraints = false
        leftView.addSubview(menuView)
        NSLayoutConstraint.activate([
            menuView.topAnchor.constraint(equalTo: leftView.topAnchor),
            menuView.bottomAnchor.constraint(equalTo: leftView.bottomAnchor),
            menuView.trailingAnchor.constraint(equalTo: leftView.trailingAnchor),
            menuView.leadingAnchor.constraint(equalTo: leftView.leadingAnchor),
            ])
        addChild(menu)
    }
    fileprivate func handleEnded(gesture:UIPanGestureRecognizer)
    {
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        if isMenuOpen
        {
            if abs(velocity.x) > 500
            {
                closeMenu()
                return
            }
            if abs(translation.x) < menuWidth / 2
            {
                openMenu()
            }
            else
            {
                closeMenu()
            }
        }
        else
        {
            if velocity.x > 500
            {
                openMenu()
                return
            }
            if abs(translation.x) > menuWidth / 2
            {
                openMenu()
            }
            else
            {
                closeMenu()
            }
        }
        
    }
    func closeMenu()
    {
        darkCoverView.isUserInteractionEnabled = false
        isMenuOpen = false
        redViewLeadingConstraint.constant = 0
        redViewTrailingConstraint.constant = 0
        animateView()
        setNeedsStatusBarAppearanceUpdate()
    }
    func openMenu()
    {
        darkCoverView.isUserInteractionEnabled = true
        isMenuOpen = true
        redViewLeadingConstraint.constant = menuWidth
        redViewTrailingConstraint.constant = menuWidth
        animateView()
        setNeedsStatusBarAppearanceUpdate()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return isMenuOpen ? .lightContent : .default
    }
    func animateView()
    {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.darkCoverView.alpha = self.isMenuOpen ? 1 : 0
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    var rightViewController:UIViewController = UINavigationController(rootViewController: HomeViewController())
    
    func selectAnItem(indexPath: IndexPath) {
        performViewCleanUp()
        closeMenu()
        switch indexPath.row {
        case 0:
            addSubController(toShowView: UINavigationController(rootViewController: HomeViewController()))
        case 1:
            addSubController(toShowView: UINavigationController(rootViewController: TrendingController()))
        default:
            addSubController(toShowView: VideosTableViewController())
        }
        rightView.bringSubviewToFront(darkCoverView)
    }
    func performViewCleanUp()
    {
        rightViewController.view.removeFromSuperview()
        rightViewController.removeFromParent()
    }
    func addSubController(toShowView:UIViewController)
    {
        rightViewController = toShowView
        rightView.addSubview(rightViewController.view)
        addChild(rightViewController)
    }
    @objc func dismissUsingDarkCoverView()
    {
        closeMenu()
    }
}

//
//  ContainerVC.swift
//  TwitterSlideOutMenu
//
//  Created by Sherif  Wagih on 12/25/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
class RightContainerView:UIView{}
class LeftContainerView:UIView{}
class DarkCoverView:UIView{}
class BaseSlidingController: UIViewController {
    var redViewLeadingConstraint:NSLayoutConstraint!
    var redViewTrailingConstraint:NSLayoutConstraint!
    var menuWidth:CGFloat = 300
    var isMenuOpen:Bool = false
    let redView:RightContainerView =  {
        let v = RightContainerView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let blueView:LeftContainerView = {
        let v = LeftContainerView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var darkCoverView : DarkCoverView = {
        let v = DarkCoverView()
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
        view.backgroundColor = .white
        setupViews()
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
        view.addSubview(redView)
        view.addSubview(blueView)
        redViewLeadingConstraint =  redView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant:0);
        redViewTrailingConstraint =
        redView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        NSLayoutConstraint.activate([
            redView.topAnchor.constraint(equalTo: view.topAnchor),
            redView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            redViewLeadingConstraint,
            redViewTrailingConstraint,
            blueView.topAnchor.constraint(equalTo: view.topAnchor),
            blueView.trailingAnchor.constraint(equalTo: redView.leadingAnchor),
            blueView.widthAnchor.constraint(equalToConstant: menuWidth),
            blueView.heightAnchor.constraint(equalTo: view.heightAnchor)
            ])
        setupViewControllers()
    }
    fileprivate func setupViewControllers()
    {
        let homeView = rightViewController.view!
        homeView.translatesAutoresizingMaskIntoConstraints = false
        redView.addSubview(homeView)
        addChild(rightViewController)
        redView.addSubview(darkCoverView)
        NSLayoutConstraint.activate([
            homeView.topAnchor.constraint(equalTo: redView.topAnchor),
            homeView.bottomAnchor.constraint(equalTo: redView.bottomAnchor),
            homeView.trailingAnchor.constraint(equalTo: redView.trailingAnchor),
            homeView.leadingAnchor.constraint(equalTo: redView.leadingAnchor),
            darkCoverView.topAnchor.constraint(equalTo: redView.topAnchor),
            darkCoverView.bottomAnchor.constraint(equalTo: redView.bottomAnchor),
            darkCoverView.trailingAnchor.constraint(equalTo: redView.trailingAnchor),
            darkCoverView.leadingAnchor.constraint(equalTo: redView.leadingAnchor)
            ])
        let menu = MenuTableViewController()
        let menuView = menu.view!
        menuView.translatesAutoresizingMaskIntoConstraints = false
        blueView.addSubview(menuView)
        NSLayoutConstraint.activate([
            menuView.topAnchor.constraint(equalTo: blueView.topAnchor),
            menuView.bottomAnchor.constraint(equalTo: blueView.bottomAnchor),
            menuView.trailingAnchor.constraint(equalTo: blueView.trailingAnchor),
            menuView.leadingAnchor.constraint(equalTo: blueView.leadingAnchor),
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
    }
    func openMenu()
    {
        darkCoverView.isUserInteractionEnabled = true
        isMenuOpen = true
        redViewLeadingConstraint.constant = menuWidth
        redViewTrailingConstraint.constant = menuWidth
        animateView()
    }
    func animateView()
    {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.darkCoverView.alpha = self.isMenuOpen ? 1 : 0
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    var rightViewController:UIViewController = UINavigationController(rootViewController: HomeViewController())
    func  didSelectMenuItem(indexPath:IndexPath)
    {
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
        redView.bringSubviewToFront(darkCoverView)
    }
    func performViewCleanUp()
    {
        rightViewController.view.removeFromSuperview()
        rightViewController.removeFromParent()
    }
    func addSubController(toShowView:UIViewController)
    {
        rightViewController = toShowView
        redView.addSubview(rightViewController.view)
        addChild(rightViewController)
    }
    @objc func dismissUsingDarkCoverView()
    {
        closeMenu()
    }
}

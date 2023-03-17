//
//  TaskBarViewController.swift
//  testTask
//
//  Created by BigSynt on 04.03.2023.
//  Copyright © 2023 BigSynt. All rights reserved.
//

import UIKit

class TaskBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    var blurEffectView = UIVisualEffectView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
        UITabBar.appearance().backgroundImage = UIImage()
        self.tabBar.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6277056277)
        
        self.tabBar.tintColor = #colorLiteral(red: 0.3791264296, green: 0.6772331595, blue: 0.6454673409, alpha: 1)
        self.tabBar.unselectedItemTintColor = .gray
        self.tabBar.itemPositioning = .centered
        self.tabBar.itemWidth = CGFloat(110)
        
        configureBlurView()
        
        let mainVC = mainVCConfig()
        let favoritesVC = favoritesVCConfig()
        setViewControllers([mainVC, favoritesVC], animated: false)
    }

    func configureBlurView() {
        let blurEffect = UIBlurEffect(style: .dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = CGRect(x: 0, y: view.frame.height - tabBar.frame.height, width: view.frame.width, height: tabBar.frame.height)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0.8
        view.insertSubview(blurEffectView, belowSubview: tabBar)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex

        print(tabBarIndex)
//        if tabBarController.tabBar.tag == 0 {
//
//            //self.navigationController?.navigationBar.isHidden = true
//            self.tabBarItem = UITabBarItem(title: "Товары3", image: UIImage(systemName: "star"), tag: 0)//"leaf.fill"
//            self.tabBar.backgroundColor = .black
//            self.navigationItem.title = "Товары2"
//        }
//        if tabBarIndex == 1 {
//            self.navigationController?.isNavigationBarHidden = false
//            self.navigationItem.title = "Избранные"
//        }
    }
    
//    let tabBarView = TabBarViewController()
//           tabBarView.getData(data: UID)
//           self.navigationController?.pushViewController(tabBarView, animated: true)
    
    
    
    private func mainVCConfig() -> UINavigationController {
        let mainScreenController = MainScreenController()
        let presenter = MainScreenPresenter()
        mainScreenController.presenter = presenter
        presenter.view = mainScreenController
        let navVC = UINavigationController(rootViewController: mainScreenController)
        var tabBarItem = UITabBarItem()
        let imageProduct = UIImage(named: "leaf.fill")
        tabBarItem = UITabBarItem(title: "product", image: imageProduct, tag: 0)
        navVC.tabBarItem = tabBarItem
        return navVC
    }
    
    private func favoritesVCConfig() -> UINavigationController {
        let favoritesController = MainScreenController()
        let navVC = UINavigationController(rootViewController: favoritesController)
        let imageProduct = UIImage(systemName: "heart.fill")
        tabBarItem = UITabBarItem(title: "favorites", image: imageProduct, tag: 1)
        navVC.tabBarItem = tabBarItem
        return navVC
    }
}

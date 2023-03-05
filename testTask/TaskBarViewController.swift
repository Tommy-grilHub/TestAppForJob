//
//  TaskBarViewController.swift
//  testTask
//
//  Created by BigSynt on 04.03.2023.
//  Copyright © 2023 BigSynt. All rights reserved.
//

import UIKit

class TaskBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
        //self.navigationItem.title = "new"
        
        let mainVC = mainVCConfig()
        setViewControllers([mainVC], animated: false)
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
        var imageProduct = UIImage(named: "leaf.fill")
        tabBar.barTintColor = .white
        tabBar.tintColor = .gray
        tabBarItem = UITabBarItem(title: "product", image: imageProduct, tag: 0)
        navVC.tabBarItem = tabBarItem
        return navVC
    }
}

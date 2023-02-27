//
//  AppDelegate.swift
//  testTask
//
//  Created by BigSynt on 19.01.2023.
//  Copyright © 2023 BigSynt. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //let mainScreenVC = mainVCConfig()
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navC = UINavigationController(rootViewController: MainScreenController())
        navC.setNavigationBarHidden(true, animated: true)
        window.rootViewController = navC
        
        //window.rootViewController = mainScreenVC
        window.makeKeyAndVisible()
        self.window = window

        return true
    }
    
//    private func mainVCConfig() -> UINavigationController {
//         
//        let presenter = MainScreenPresenter()
//        let mainScreen = MainScreenController()
//        mainScreen.presenter = presenter
//        presenter.view = mainScreen
//        //mainScreen.presenter?.getData()
//        let navVC = UINavigationController(rootViewController: mainScreen)
//        //navVC.setNavigationBarHidden(true, animated: true)
//
//        return navVC
//    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


//
//  AppDelegate.swift
//  CodeChallengeIOS
//
//  Created by Lê Hùng on 8/27/20.
//  Copyright © 2020 hungle. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UINavigationBar.appearance().barTintColor = UIColor.init(red: 1/255.0, green: 77/255.0, blue: 120/255.0, alpha: 1.0)
        UINavigationBar.appearance().tintColor = UIColor.white//UIColor.init(red: 1/255.0, green: 77/255.0, blue: 120/255.0, alpha: 1.0)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.gray
        let main = MainViewController(nibName: "MainViewController", bundle: nil)
        let nav = UINavigationController(rootViewController: main)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
        return true
    }


}


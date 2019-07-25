//
//  AppDelegate.swift
//  SystemColors
//
//  Created by Richard W Maddy on 6/4/19.
//  Copyright © 2019 Richard W Maddy. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    // For iOS 12 or earlier
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let vc = ViewController()
        let nc = UINavigationController(rootViewController: vc)
        let win = UIWindow(frame: UIScreen.main.bounds)
        win.rootViewController = nc
        win.makeKeyAndVisible()
        window = win

        return true
    }
}


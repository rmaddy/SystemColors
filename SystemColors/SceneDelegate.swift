//
//  SceneDelegate.swift
//  SystemColors
//
//  Created by Richard W Maddy on 6/4/19.
//  Copyright © 2019 Richard W Maddy. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    // For iOS 13 or later
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let winScene = (scene as? UIWindowScene) else { return }

        let vc = ViewController()
        let nc = UINavigationController(rootViewController: vc)
        let win = UIWindow(windowScene: winScene)
        win.rootViewController = nc
        win.makeKeyAndVisible()
        window = win
    }
}


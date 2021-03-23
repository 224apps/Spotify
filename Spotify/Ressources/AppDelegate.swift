//
//  AppDelegate.swift
//  Spotify
//
//  Created by Abdoulaye Diallo on 3/23/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let window = UIWindow(frame: UIScreen.main.bounds)
        if AuthManager.shared.isSignedIn {
            window.rootViewController = TabBarViewController()
        }else{
            let nvc = UINavigationController(rootViewController: WelcomeViewController())
            nvc.navigationBar.prefersLargeTitles = true
            nvc.viewControllers.first?.navigationItem.largeTitleDisplayMode = .always
            window.rootViewController = nvc
        }
        
        self.window = window
        window.makeKeyAndVisible()
        return true
    }
}


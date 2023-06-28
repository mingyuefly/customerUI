//
//  AppDelegate.swift
//  moveImage
//
//  Created by gmy on 2023/6/28.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootVC = ViewController()
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
        
        return true
    }


}


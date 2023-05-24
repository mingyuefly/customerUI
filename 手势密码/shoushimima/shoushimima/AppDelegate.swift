//
//  AppDelegate.swift
//  shoushimima
//
//  Created by mingyue on 15-7-24.
//  Copyright (c) 2015年 csii. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds);
        self.window?.backgroundColor = UIColor.white;
        
        let vc = ViewController();
        self.window?.rootViewController = vc;
        self.window?.makeKeyAndVisible();
        
        return true
    }

}


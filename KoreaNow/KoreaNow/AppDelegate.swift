//
//  AppDelegate.swift
//  KoreaNow
//
//  Created by 김동현 on 2020/10/03.
//  Copyright © 2020 김동현. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: MainVC())
        window?.makeKeyAndVisible()
        return true
    }


}


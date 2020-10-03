//
//  AppDelegate.swift
//  KoreaNow
//
//  Created by 김동현 on 2020/10/03.
//  Copyright © 2020 김동현. All rights reserved.
//


//App ID Prefix
//RA99PDU87Z (Team ID)

// Firebase callback URL
//https://koreanow-3e42c.firebaseapp.com/__/auth/handler

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = MainTabVC()
        window?.makeKeyAndVisible()
        return true
    }


}


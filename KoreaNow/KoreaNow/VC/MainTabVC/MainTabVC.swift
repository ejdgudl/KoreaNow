//
//  MainTabVC.swift
//  KoreaNow
//
//  Created by 김동현 on 2020/10/03.
//  Copyright © 2020 김동현. All rights reserved.
//

import UIKit

class MainTabVC: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        configureViewController()
    }
    
    func configureViewController() {
        
        let mainVC = constructNavController(unSelectedImage: UIImage(named: ""), selectedImage: UIImage(named: "home_selected"), rootViewController: MainVC())
        
        let profileVC = constructNavController(unSelectedImage: UIImage(named: "search_unselected"), selectedImage: UIImage(named: "search_selected"), rootViewController: ProfileVC())
        profileVC.title = "프로필"
        viewControllers = [mainVC, profileVC]
        
        tabBar.tintColor = .black
        
    }
    
    // Construct NavigationController
    func constructNavController(unSelectedImage: UIImage?, selectedImage: UIImage?, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        
        // Construct NavController
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.image = unSelectedImage
        navController.tabBarItem.selectedImage = selectedImage
        navController.navigationBar.tintColor = .black
        
        // Return NavController
        return navController
        
    }
}

//
//  MainTabVC.swift
//  KoreaNow
//
//  Created by 김동현 on 2020/10/03.
//  Copyright © 2020 김동현. All rights reserved.
//

import UIKit
import Firebase

class MainTabVC: UITabBarController, UITabBarControllerDelegate {
    
    // MARK: - Properties
    private let main = MainVC()
    private let profile = ProfileVC()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(loginNotiFunc), name: .loginName, object: nil)
        
        self.delegate = self
        
        configureViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchUser()
    }
    
    // MARK: - @objc
    @objc private func loginNotiFunc(noti: Notification) {
        guard let userInfo = noti.userInfo as? [String: User] else { return }
        guard let user = userInfo["user"] else { return }
        main.user = user
        profile.user = user
    }
    
    // MARK: - Helpers
    func configureViewController() {
        
        let mainVC = constructNavController(unSelectedImage: UIImage(named: ""), selectedImage: UIImage(named: "home_selected"), rootViewController: main)
        
        let profileVC = constructNavController(unSelectedImage: UIImage(named: "search_unselected"), selectedImage: UIImage(named: "search_selected"), rootViewController: profile)
        
        mainVC.title = "뉴스"
        profileVC.title = "프로필"
        
        viewControllers = [mainVC, profileVC]
        
        tabBar.tintColor = .black
        
    }
    
    func constructNavController(unSelectedImage: UIImage?, selectedImage: UIImage?, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.image = unSelectedImage
        navController.tabBarItem.selectedImage = selectedImage
        navController.navigationBar.tintColor = .black
        
        return navController
    }
    
    
    func fetchUser() {
        self.view.makeToastActivity(.center)
        FirebaseService.share.getUserData { [weak self] (user) -> (Void) in
            guard let self = self else { return }
            
            self.main.user = user
            self.profile.user = user
            self.view.hideToastActivity()
            self.view.makeToast("Success Networking", duration: 1)
            
        }
    }
}

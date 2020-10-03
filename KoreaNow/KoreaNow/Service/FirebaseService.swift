//
//  FirebaseService.swift
//  KoreaNow
//
//  Created by 김동현 on 2020/10/03.
//  Copyright © 2020 김동현. All rights reserved.
//

import UIKit
import Firebase

final class FirebaseService {
    
    // MARK: - Properties
    static let share = FirebaseService()
    
    // MARK: - Init
    private init() {}
    
    // MARK: - Logout Handler
    // Logout
    public func logoutHandler(vc: UIViewController) {
        if (Auth.auth().currentUser?.uid) != nil {
            let firebaseAuth = Auth.auth()
            do {
                // SignOut Firebase
                try firebaseAuth.signOut()
                let logVC = LogVC()
                logVC.modalPresentationStyle = .fullScreen
                vc.present(logVC, animated: true)
                print("----- FB AUTH SUCCESS ( logout ) -----")
                
            } catch let signOutError as NSError {
                print ("----- FB AUTH ERROR ( logout ) ----- Error signing out: %@", signOutError)
            }
        } else {
            print("----- FB AUTH ERROR ( currentUser?.uid is nil ) -----")
        }
    }
    
    // MARK: - Check User Log Status
    // App 실행시 MainVC viewDidLoad에서 실행하여 Login 여부 판단 후 첫 화면 결정.
    public func checkUserIsLoggedIn(vc: MainVC) {
        if Auth.auth().currentUser == nil {
            print("----- FB AUTH ( currentUser is nil ) ----- ")
            let logVC = LogVC()
            logVC.modalPresentationStyle = .fullScreen
            vc.present(logVC, animated: true)
        } else {
            print("----- FB AUTH ( have currentUser ) ----- ")
        }
    }
}

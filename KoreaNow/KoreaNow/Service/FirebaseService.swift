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
    
    // MARK: - Get User Data
    public func getUserData( complition: @escaping (User) -> (Void)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { (snapshot) in
            if let dic = snapshot.value as? Dictionary<String, AnyObject> {
                guard let name = dic["name"] as? String else { return }
                guard let email = dic["email"] as? String else { return }
                let user = User(name: name, email: email)
                
                complition(user)
            }
        }
    }
    
    // getTimeSort
    func getTimeSort(seq: Int, complition: @escaping ([String]) -> ()) {
        Database.database().reference().child("comments").child(String(seq)).observeSingleEvent(of: .value) { (snapshot) in
            guard let value = snapshot.value as? [String: Any] else { return }
            let timeArray = value.keys.sorted()
            complition(timeArray)
        }
    }
    
    // MARK: - Get Comment
    public func getComment(seq: Int?, complition: @escaping ([Comment]) -> ()) {
        guard let seq = seq else { return }
        
        self.getTimeSort(seq: seq) { timeArray in
            var commentArray = [Comment]()
            timeArray.forEach {
                Database.database().reference().child("comments").child(String(seq)).child($0).observeSingleEvent(of: .value) { (snapshot) in
                    guard let nameAndText = snapshot.value as? [String: String] else { return }
                    guard let name = nameAndText.keys.first else { return }
                    guard let text = nameAndText.values.first else { return }
                    commentArray.append(Comment(name: name, commentText: text, time: snapshot.key))
                    complition(commentArray)
                }
            }
        }
            
    }
}

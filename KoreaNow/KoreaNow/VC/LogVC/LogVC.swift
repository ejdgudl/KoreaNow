//
//  LogVC.swift
//  KoreaNow
//
//  Created by 김동현 on 2020/10/03.
//  Copyright © 2020 김동현. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import Toast_Swift
import AuthenticationServices

class LogVC: UIViewController {
    
    // MARK: - Properties
    private let titleLabel : UILabel = {
       let label = UILabel()
        label.text = "Korea Now"
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    fileprivate var currentNonce: String? // when signIn with apple
    
    private let appleLoginButton: ASAuthorizationAppleIDButton = {
        let button = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn, authorizationButtonStyle: .black)
        button.addTarget(self, action: #selector(loginButtonHandler), for: .touchUpInside)
        return button
    }()
    
    private let db = Database.database().reference()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureViews()
    }
    
    // MARK: - @objc
    @objc private func loginButtonHandler() {
        
        let nonce = randomNonceString()
        currentNonce = nonce
        
        let appleLoginRequest = ASAuthorizationAppleIDProvider().createRequest()
        appleLoginRequest.requestedScopes = [.fullName, .email]
        appleLoginRequest.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [appleLoginRequest])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self as? ASAuthorizationControllerPresentationContextProviding
        authorizationController.performRequests()
    }
    
    // MARK: - Configure
    private func configure() {
        
    }
    
    // MARK: - ConfigureViews
    private func configureViews() {
        view.backgroundColor = .white
        
        [titleLabel, appleLoginButton].forEach {
            view.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.width.equalToSuperview()
            make.height.equalTo(250)
            make.top.equalToSuperview().inset(100)
        }
        
        appleLoginButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.titleLabel.snp.bottom).offset(80)
            make.left.right.equalToSuperview().inset(80)
            make.height.equalTo(40)
        }
    }
}

// MARK: - Extension ASAuthorizationControllerDelegate
@available(iOS 13.0, *)
extension LogVC: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        // When authentication is successful
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("-----Apple print----- Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("-----Apple print----- Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("-----Apple print----- Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            
            // Initialize a Firebase credential.
            let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                      idToken: idTokenString,
                                                      rawNonce: nonce)
            
            // Sign in with Firebase.
            Auth.auth().signIn(with: credential) { [weak self] (authData, error) in
                guard let self = self else { return }
                
                if let error = error {
                    print("----- FB AUTH ERROR (signin) \(error.localizedDescription) -----")
                    return
                } else {
                    
                    // User is signed in to Firebase with Apple.
                    self.view.makeToastActivity(.center)
                    guard let authData = authData else { return }
                    
                    guard let email = authData.user.email else { return }
                    
                    let uid = authData.user.uid
                    
                    // Flow -> observeSingleEvent - ifFirstUser - UpdateChildValues
                    self.db.child("users").child(uid).observeSingleEvent(of: .value) { (snapshot) in
                        
                        // When first join user
                        if (snapshot.value as? Dictionary<String, AnyObject>) == nil {
                            self.view.hideToastActivity()
                            var resultName = ""
                            if let fullName = appleIDCredential.fullName {
                                if let givenName = fullName.givenName {
                                    if let familyName = fullName.familyName {
                                        resultName = familyName + givenName
                                    }
                                }
                            }
                            
                            let dictionaryValue = [
                                "email": email,
                                "name": resultName
                            ]
                            self.db.child("users").updateChildValues([uid: dictionaryValue]) { (error, ref) in
                                print("----- FB DATABASE SUCCESS (created user and saved information to database) -----")
                            }
                        } else {
                            
                            // When already join user
                            print("----- FB DATABASE (this user is already a member)-----")
                        }
                        
                        FirebaseService.share.getUserData { (user) -> (Void) in
                            let userInfo: [String: User] = [
                                "user": user
                            ]
                            NotificationCenter.default.post(name: .loginName, object: nil, userInfo: userInfo)
                            
                            self.view.hideToastActivity()
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                }
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // When Sign in with Apple errored
        print("---Apple print--- Sign in with Apple errored: \(error)")
    }
}



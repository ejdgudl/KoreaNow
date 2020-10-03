//
//  ProfileVC.swift
//  KoreaNow
//
//  Created by 김동현 on 2020/10/03.
//  Copyright © 2020 김동현. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    // MARK: Properties
    public  var user: User? {
        didSet {
            print("----- In ProfileVC USER From NOTI \(String(describing: user)) -----")
        }
    }
    
    private let logoutButton: UIButton = {
       let button = UIButton()
        button.addTarget(self, action: #selector(didTapLogoutButton), for: .touchUpInside)
        button.setTitle("zzzz", for: .normal)
        button.backgroundColor = .red
        return button
    }()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureNavi()
        configureViews()
    }
    
    // MARK: - @objc
    @objc private func didTapLogoutButton() {
        FirebaseService.share.logoutHandler(vc: self)
    }
    
    // MARK: Configure
    private func configure() {
        
    }
    
    // MARK: - ConfigureNAvi
    private func configureNavi() {
        
    }
    
    // MARK: ConfigureViews
    private func configureViews() {
        view.backgroundColor = .white
        
        [logoutButton].forEach {
            view.addSubview($0)
        }
        
        logoutButton.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
        }
    }
}

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
            emailTitle.text = user?.email
            nameLabel.text = user?.name
        }
    }
    
    private let appTitleLabel: UILabel = {
       let label = UILabel()
        label.text = "Korea Now"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 50, weight: .bold)
        return label
    }()
    
    private let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "KoreaBG")
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0.7
        return imageView
    }()
    
    private let emailTitle: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private let nameLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private let logoutButton: UIButton = {
       let button = UIButton()
        button.addTarget(self, action: #selector(didTapLogoutButton), for: .touchUpInside)
        button.setTitle("로그아웃", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 25, weight: .semibold)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let versionLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17, weight: .light)
        label.text = "1.0 Version"
        return label
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
        alertNormal(title: "로그아웃", message: "로그아웃 하시겠습니까?") { [weak self] (_) in
            guard let self = self else { return }
            FirebaseService.share.logoutHandler(vc: self)
        }
    }
    
    // MARK: Configure
    private func configure() {
        
    }
    
    // MARK: - ConfigureNAvi
    private func configureNavi() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: ConfigureViews
    private func configureViews() {
        view.backgroundColor = .white
        
        [imageView, appTitleLabel, emailTitle, nameLabel, logoutButton, versionLabel].forEach {
            view.addSubview($0)
        }
        
        imageView.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
        }
        
        appTitleLabel.snp.makeConstraints { [weak self] (make) in
            guard let self = self else { return }
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(40)
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(170)
        }
        
        emailTitle.snp.makeConstraints { [weak self] (make) in
            guard let self = self else { return }
            make.top.equalTo(self.appTitleLabel.snp.bottom).offset(40)
            make.left.right.equalTo(self.appTitleLabel)
        }
        
        nameLabel.snp.makeConstraints { [weak self] (make) in
            guard let self = self else { return }
            make.top.equalTo(self.emailTitle.snp.bottom).offset(40)
            make.left.right.equalTo(self.appTitleLabel)
        }
        
        logoutButton.snp.makeConstraints { [weak self] (make) in
            guard let self = self else { return }
            make.top.equalTo(self.nameLabel.snp.bottom).offset(40)
            make.left.right.equalTo(self.appTitleLabel)
        }
        
        versionLabel.snp.makeConstraints { [weak self] (make) in
            guard let self = self else { return }
            make.top.equalTo(self.logoutButton.snp.bottom).offset(40)
            make.left.right.equalTo(self.appTitleLabel)
        }
    }
}

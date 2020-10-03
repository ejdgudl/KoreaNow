//
//  BoardDetailVC.swift
//  KoreaNow
//
//  Created by 김동현 on 2020/10/03.
//  Copyright © 2020 김동현. All rights reserved.
//

import UIKit
import WebKit

class BoardDetailVC: UIViewController {
    
    // MARK: Properties
    public var user: User?
    public var seq: Int?
    
    public var webURL: URL?
    
    private lazy var webView: WKWebView = {
        let view = WKWebView()
        if let url = self.webURL {
            view.load(URLRequest(url: url))
        }
        return view
    }()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureNavi()
        configureViews()
    }
    
    // MARK: - @objc
    @objc private func didTapCommentButton() {
        let commentVC = CommentVC()
        commentVC.seq = self.seq
        commentVC.user = self.user
        let nav = UINavigationController(rootViewController: commentVC)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    // MARK: Configure
    private func configure() {

    }
    
    // MARK: - ConfigureNavi
    private func configureNavi() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "댓글 달기", style: .plain, target: self, action: #selector(didTapCommentButton))
    }
    
    // MARK: ConfigureViews
    private func configureViews() {
        view.backgroundColor = .white
        
        [webView].forEach {
            view.addSubview($0)
        }
        
        webView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}


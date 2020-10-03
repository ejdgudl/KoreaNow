//
//  CommentVC.swift
//  KoreaNow
//
//  Created by 김동현 on 2020/10/03.
//  Copyright © 2020 김동현. All rights reserved.
//

import UIKit

class CommentVC: UIViewController {
    
    // MARK: Properties
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        return tableView
    }()
    
    private var containerView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 55)
        view.backgroundColor = .white
        return view
    }()
    
    private let commentTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "댓글을 입력해주세요..."
        return tf
    }()
    
    private lazy var postButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("게시", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(didTapPostButton), for: .touchUpInside)
        return button
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureNavi()
        configureViews()
    }
    
    // MARK: - Override
    override var inputAccessoryView: UIView? {
        get {
            return containerView
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    // MARK: - @objc
    @objc private func didTapPostButton() {
        
    }
    
    // MARK: Configure
    private func configure() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(CommentCell.self, forCellReuseIdentifier: CommentCell.cellID)
    }
    
    // MARK: - ConfigureNavi
    private func configureNavi() {
        title = "댓글"
    }
    
    // MARK: ConfigureViews
    private func configureViews() {
        view.backgroundColor = .white
        
        [tableView].forEach {
            view.addSubview($0)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        [postButton, commentTextField, separatorView].forEach {
            containerView.addSubview($0)
        }
        
        postButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
            make.width.equalTo(50)
        }
        
        commentTextField.snp.makeConstraints { [weak self] (make) in
            guard let self = self else { return }
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().inset(12)
            make.right.equalTo(self.postButton.snp.left).inset(8)
        }
        
        separatorView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
}

extension CommentVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.cellID, for: indexPath) as? CommentCell else {
            print("----- CELLFORROWAT ERROR (dequeue error) -----")
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        commentTextField.resignFirstResponder()
    }
}


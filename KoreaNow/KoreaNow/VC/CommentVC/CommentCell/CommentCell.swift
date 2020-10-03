//
//  CommentCell.swift
//  KoreaNow
//
//  Created by 김동현 on 2020/10/03.
//  Copyright © 2020 김동현. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
    
    // MARK: Properties
    var comment: Comment? {
        didSet {
            nickNameLabel.text = comment?.name
            commentLabel.text = comment?.commentText
            postDateLabel.text = comment?.time
        }
    }
    
    private let nickNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private let postDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .light)
        return label
    }()
    
    static let cellID = "CommentCellID"
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    private func configure() {
        selectionStyle = .none
    }
    
    // MARK: ConfigureViews
    private func configureViews() {
        backgroundColor = .white
        
        [nickNameLabel, commentLabel, postDateLabel].forEach {
            addSubview($0)
        }
        
        nickNameLabel.snp.makeConstraints { [weak self] (make) in
            guard let self = self else { return }
            make.top.left.equalToSuperview().inset(15)
            make.right.equalTo(self.snp.centerX)
        }
        
        postDateLabel.snp.makeConstraints { [weak self] (make) in
            guard let self = self else { return }
            make.top.bottom.equalTo(self.nickNameLabel)
            make.right.equalToSuperview().inset(15)
        }
        
        commentLabel.snp.makeConstraints { [weak self] (make) in
            guard let self = self else { return }
            make.top.equalTo(self.nickNameLabel.snp.bottom).offset(10)
            make.left.equalTo(self.nickNameLabel)
            make.right.equalTo(self.postDateLabel.snp.right)
            make.bottom.equalToSuperview().inset(15)
        }
        
    }
}


//
//  BoardCell.swift
//  KoreaNow
//
//  Created by 김동현 on 2020/10/03.
//  Copyright © 2020 김동현. All rights reserved.
//

import UIKit
import Kingfisher

class BoardCell: UITableViewCell {
    
    // MARK: - Properties
    public var board: Board? {
        didSet {
            if let imagePath = board?.imagePath {
                guard let imageUrl = URL(string: baseImageURL + imagePath) else {
                    print("----- BOARDCELL ERROR (wrong imageURL)-----")
                    return
                }
                boardImageView.kf.setImage(with: imageUrl)
            }
            
            boardTitleView.text = board?.title
            postDateLabel.text = board?.postDate
        }
    }
    
    private let boardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.4
        imageView.layer.shadowOffset = CGSize(width: 1, height: 1)
        imageView.layer.masksToBounds = false
        return imageView
    }()
    
    private let boardTitleView: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private let postDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textAlignment = .right
        return label
    }()
    
    static let cellID = "BordCellID"
    
    private let baseImageURL = "http://www.kocis.go.kr"
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ConfigureViews
    private func configureViews() {
        backgroundColor = .white
        
        [boardImageView, boardTitleView, postDateLabel].forEach {
            addSubview($0)
        }
        
        boardImageView.snp.makeConstraints { [weak self] (make) in
            guard let self = self else { return }
            make.centerX.equalToSuperview()
            make.top.left.right.equalToSuperview().inset(30)
            make.height.equalTo(self.boardImageView.snp.width).multipliedBy(0.65)
        }
        
        boardTitleView.snp.makeConstraints { [weak self] (make) in
            guard let self = self else { return }
            make.top.equalTo(self.boardImageView.snp.bottom).offset(20)
            make.left.right.equalTo(self.boardImageView)
        }
        
        postDateLabel.snp.makeConstraints { [weak self] (make) in
            guard let self = self else { return }
            make.top.equalTo(self.boardTitleView.snp.bottom).offset(18)
            make.left.right.equalTo(self.boardImageView)
            make.bottom.equalToSuperview().inset(20)
        }
        
    }
}

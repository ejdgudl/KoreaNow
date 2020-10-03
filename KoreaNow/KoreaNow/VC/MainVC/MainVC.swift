//
//  MainVC.swift
//  KoreaNow
//
//  Created by 김동현 on 2020/10/03.
//  Copyright © 2020 김동현. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire

class MainVC: UIViewController {
    
    // MARK: Properties
    private var boardList: [Board]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        return tableView
    }()
    
    private let baseWebURL = "http://www.kocis.go.kr/press/view.do"
    
    private var page = 1
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNewsData()
        configure()
        configureNavi()
        configureViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchNewsData()
    }
    
    // MARK: - Helpers
    private func fetchNewsData() {
        
        NewsService.getNews(page: String(self.page)) { [weak self] (newsData) in
            guard let self = self else { return }
            self.boardList = newsData.boardList
        }
    }
    
    // paging
    private func loadMoreData() {
        self.page += 1
        NewsService.moreGetNews(page: String(self.page)) { [weak self] (boardList) in
            guard let self = self else { return }
            
            boardList.forEach {
                self.boardList?.append($0)
            }
            self.tableView.reloadData()
        }
    }
    
    // MARK: Configure
    private func configure() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(BoardCell.self, forCellReuseIdentifier: BoardCell.cellID)
    }
    
    // MARK: - ConfigureNavi
    private func configureNavi() {
        title = "Korea Timeline Slider"
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
    }

}

// MARK: - Extension TableView
extension MainVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let boardList = self.boardList else {
            print("----- NUMBEROFROWS ERROR (boardList is nil) -----")
            return 0
        }
        
        return boardList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BoardCell.cellID, for: indexPath) as? BoardCell else {
            print("----- CELLFORROWAT ERROR (dequeue error) -----")
            return UITableViewCell()
        }
        
        guard let boardList = self.boardList else {
            print("----- CELLFORROWAT ERROR (boardList is nil) -----")
            return UITableViewCell()
        }
        
        cell.board = boardList[indexPath.row]
        
        // paging
        if indexPath.row == boardList.count - 1 {
            loadMoreData()
        }
        
        return cell
    }
    
    // didselect
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let boardList = self.boardList else {
            print("----- DIDSELECT ERROR (boardList is nil) -----")
            return
        }
        
        let seq = boardList[indexPath.row].seq
        
        guard let webURL = URL(string: baseWebURL + "?seq=\(String(seq))") else {
            print("----- DID SELECT ERROR (url init error) -----")
            return
        }

        let boardDetailVC = BoardDetailVC()
        boardDetailVC.webURL = webURL
        navigationController?.pushViewController(boardDetailVC, animated: true)
    }
}

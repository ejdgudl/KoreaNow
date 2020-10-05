//
//  NewsData.swift
//  KoreaNow
//
//  Created by 김동현 on 2020/10/03.
//  Copyright © 2020 김동현. All rights reserved.
//

import Foundation

struct NewsData: Codable {
    let totalCount: Int
    let page: String
    let pageSize: String
    let boardList: [Board]
}

struct Board: Codable {
    
    let postDate: String
    let htmlContent: String
    let imagePath: String
    let title: String
    let seq: Int
    
    enum CodingKeys: String, CodingKey {
        case postDate = "POSTDATE"
        case htmlContent = "HTML_CONTENT"
        case imagePath = "IMAGE_PATH"
        case title = "TITLE"
        case seq = "SEQ"
    }
}

struct User {
    let name: String
    let email: String
}

struct Comment {
    let name: String
    let commentText: String
    let time: String
}
    

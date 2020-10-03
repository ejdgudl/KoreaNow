//
//  NewsService.swift
//  KoreaNow
//
//  Created by 김동현 on 2020/10/03.
//  Copyright © 2020 김동현. All rights reserved.
//

import Foundation
import Alamofire

final class NewsService {
    
    // MARK: - Properties
    static let share = NewsService()
    
    // MARK: - Init
    private init() {}
    
    // MARK: - Herlpers
    static func getNews(page: String, complition: @escaping (NewsData) -> ()) {
        
        AF.request("http://www.kocis.go.kr/json/press.do?page=\(page)&pageSize=10", method: .get).response { (res) in
//            debugPrint(res)
            if let error = res.error {
                print("----- AF RESPONSE ERROR [GET] (news)----- \(error.localizedDescription)")
            }
            
            guard let code = res.response?.statusCode else {
                return
            }
            
            if code >= 200, code <= 299 {
                
                switch res.result {
                    
                case .success(let data):
                    do {
                        guard let data = data else { return }
                        let newsData = try JSONDecoder().decode(NewsData.self, from: data)
                        complition(newsData)
                        print("----- JSONDecoder SUCCESS [GET] (news)----- ")
                        
                    } catch let error {
                        print("----- JSONDecoder ERROR [GET] (news)-----  \(error.localizedDescription)")
                    }
                    
                case .failure(let error):
                    print("----- AF RESULT FAIL [GET] (news)----- \(error.localizedDescription)")
                }
            }
        }
    }
    
    
    static func moreGetNews(page: String, complition: @escaping ([Board]) -> ()) {
        
        AF.request("http://www.kocis.go.kr/json/press.do?page=\(page)&pageSize=10", method: .get).response { (res) in
            debugPrint(res)
            if let error = res.error {
                print("----- AF RESPONSE ERROR [GET] (more news)----- \(error.localizedDescription)")
            }
            
            guard let code = res.response?.statusCode else {
                return
            }
            
            if code >= 200, code <= 299 {
                
                switch res.result {
                    
                case .success(let data):
                    do {
                        guard let data = data else { return }
                        let newsData = try JSONDecoder().decode(NewsData.self, from: data)
                        complition(newsData.boardList)
                        print("----- JSONDecoder SUCCESS [GET] (more news)----- ")
                        
                    } catch let error {
                        print("----- JSONDecoder ERROR [GET] (more news)-----  \(error.localizedDescription)")
                    }
                    
                case .failure(let error):
                    print("----- AF RESULT FAIL [GET] (more news)----- \(error.localizedDescription)")
                }
            }
        }
    }
    
}


//
//  NewsListRepository.swift
//  F5_Noticias
//
//  Created by Milena Alegre on 31/08/24.
//

import Foundation

enum NewsListError: Error{
    case fileNotFound
}

class NewsListRepository {
    static var shared: NewsListRepository = {
        let instance = NewsListRepository()
        return instance
    } ()
    
    private init() {}
    
    func getNewsList(completion: ([NewsModel]?, Error?) -> Void){
            if let path = Bundle.main.path(forResource: "NewsList", ofType: "json"){
            do {
                let url = URL(fileURLWithPath: path)
                let data = try Data (contentsOf: url, options: .mappedIfSafe)
                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
                let newsModelList = try decoder.decode([NewsModel].self, from: data)
                completion(newsModelList, nil)
            } catch{
                print("\(error)")
                completion(nil, error)
            }
        } else {
            completion(nil, NewsListError.fileNotFound)
        }
    }
}
    
    
    


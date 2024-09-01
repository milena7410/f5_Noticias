//
//  NewsListLocalDataProvider.swift
//  F5_Noticias
//
//  Created by Milena Alegre on 31/08/24.
//

import Foundation

protocol NewsListLocalDataProviderProtocol: GenericDataProvider{}

class NewsListLocalDataProvider: DataProviderManager<NewsListLocalDataProviderProtocol, 
                                    NewsModel>{
    
    func getNewsList(){
        NewsListRepository.shared.getNewsList{ newModelList, error in
            if let error = error {
                self.delegate?.errorData(_provide: self.delegate, error: error)
                return
            }
            if let model = newModelList{
                self.delegate?.sucess(model: model)
            }
        }
    }
}

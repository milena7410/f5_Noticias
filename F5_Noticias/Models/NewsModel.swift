//
//  NewsModel.swift
//  F5_Noticias
//
//  Created by Milena Alegre on 31/08/24.
//

import Foundation

struct NewsModel: Codable{
    var source: SourceModel
    var author: String?
    var title: String
    var description: String?
    var url: String
    var urlToImage: String?
    var publishedAt: Date
    var content: String?
}

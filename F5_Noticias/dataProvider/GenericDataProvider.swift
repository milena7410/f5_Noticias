//
//  GenericDataProvider.swift
//  F5_Noticias
//
//  Created by Milena Alegre on 31/08/24.
//

import Foundation

protocol GenericDataProvider {
    func sucess(model: Any)
    func errorData(_provide: GenericDataProvider?, error: Error)
    }

class DataProviderManager <T, S>{
    var delegate: T?
    var model: S?
}
    
    


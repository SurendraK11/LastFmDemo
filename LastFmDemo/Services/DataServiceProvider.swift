//
//  DataServiceProvider.swift
//  DemoLastFm
//
//  Created by Surendra on 18/06/2020.
//  Copyright © 2020 Surendra. All rights reserved.
//

import Foundation

protocol DataServiceProviding {
    
    /// This allows to search for album
    /// - Parameters:
    ///   - queryBuilder: QueryBuilder is responsible to provide request to search for album
    ///   - complitionHandler: Complition handler with search result (when success - this will return tuple (albums, totalSearchResult)) otherwise error
    func searchForAlbum(_ queryBuilder: RequestQueryBuilderProtocol, complitionHandler: @escaping((Result<(albums :[Album], totalSearchResult: Int) , Error>) -> Void))
}

class DataServiceProvider {
    let httpClient: HttpClientProtocol
    init(withHttpClient httpClient: HttpClientProtocol = HttpClient(session: .shared)) {
        self.httpClient = httpClient
    }
}

extension DataServiceProvider: DataServiceProviding {
    func searchForAlbum(_ queryBuilder: RequestQueryBuilderProtocol, complitionHandler: @escaping ((Result<(albums: [Album], totalSearchResult: Int), Error>) -> Void)) {
        guard let url = queryBuilder.request() else {
            complitionHandler(.failure(CustomError.urlError))
            return
        }
        
        httpClient.procesRequest(url) { (result: Result<AlbumSearchResultResponse, Error>) in
            switch result {
            case .success(let albumSearchResultResponse):
                guard let totalResults = Int(albumSearchResultResponse.results.totalResults) else {
                    complitionHandler(.failure(CustomError.unexpectedData))
                    return
                }
                
                let albums = albumSearchResultResponse.results.albummatches.album
                complitionHandler(.success((albums: albums, totalSearchResult: totalResults)))
                
            case .failure(let error):
                complitionHandler(.failure(error))
            }
        }
    }
}

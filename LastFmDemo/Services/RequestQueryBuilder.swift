//
//  RequestQueryBuilder.swift
//  DemoLastFm
//
//  Created by Surendra on 18/06/2020.
//  Copyright © 2020 Surendra. All rights reserved.
//

import Foundation

protocol RequestQueryBuilderProtocol {
    func request() -> URL?
}

enum RequestQueryBuilder {
    
    case searchAlbum(searchTerm: String, page: Int)
    
    
    var queryItems: [URLQueryItem] {
        switch self {
        case let .searchAlbum(searchTerm, page):
            return [URLQueryItem(name: "method", value: "album.search"),
                    URLQueryItem(name: "album", value: searchTerm),
                    URLQueryItem(name: "api_key", value: APIConstants.apiKey),
                    URLQueryItem(name: "page", value: "\(page)"),
                    URLQueryItem(name: "format", value: "json")]
        
        }
    }

}

extension RequestQueryBuilder: RequestQueryBuilderProtocol {
    func request() -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = APIConstants.scheme
        urlComponents.host = APIConstants.host
        urlComponents.path = APIConstants.path
        urlComponents.queryItems = queryItems
        return urlComponents.url
    }
}


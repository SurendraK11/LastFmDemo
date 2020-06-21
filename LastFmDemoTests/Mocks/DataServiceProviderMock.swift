//
//  DataServiceProviderMock.swift
//  DemoLastFmTests
//
//  Created by Surendra on 20/06/2020.
//  Copyright © 2020 Surendra. All rights reserved.
//

@testable import LastFmDemo

enum CustomMockError: Error {
    case mockError
}

class DataServiceProviderMock: DataServiceProviding {
    
    var success: (albums:[Album], totalSearchResult:Int)?
    var exception: Error?
    
    init(withSuceess success: (albums:[Album], totalSearchResult:Int)?, exception: Error?) {
        self.success = success
        self.exception = exception
    }
    
    func searchForAlbum(_ queryBuilder: RequestQueryBuilderProtocol, complitionHandler: @escaping ((Result<(albums: [Album], totalSearchResult: Int), Error>) -> Void)) {
        
        guard let _ = success else {
            if let _ = exception {
                complitionHandler(.failure(exception!))
            } else {
                complitionHandler(.failure(CustomMockError.mockError))
            }
            return
        }
        
        complitionHandler(.success(success!))
    }
    
}

//
//  HttpClient.swift
//  DemoLastFm
//
//  Created by Surendra on 18/06/2020.
//  Copyright © 2020 Surendra. All rights reserved.
//

import Foundation

protocol HttpClientProtocol {
    /// Process network request for expected data from server
    /// - Parameters:
    ///   - url: URL
    ///   - completion: completion handler
    func procesRequest<T: Decodable> (_ url: URL, completion: @escaping (Result<T, Error>) -> ())
}


class HttpClient {
    private let session: URLSession
    init(session: URLSession) {
        self.session = session
    }
}

extension HttpClient: HttpClientProtocol {
    func procesRequest<T>(_ url: URL, completion: @escaping (Result<T, Error>) -> ()) where T : Decodable {
        let task = session.dataTask(with: url) { (data, response, error) in
             guard error == nil else {
                completion(.failure(error!))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200, let _ = data else {
                    completion(.failure(CustomError.apiResponseError))
                    return
            }
            
            do {
                // decode object in expected type
                let decodedObject = try JSONDecoder().decode(T.self, from: data!)
                completion(.success(decodedObject))
            } catch {
                print(error)
                completion(.failure(CustomError.dataParsingError))
            }
        }
        task.resume()
    }
    
}



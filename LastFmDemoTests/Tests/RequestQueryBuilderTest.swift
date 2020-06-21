//
//  RequestQueryBuilderTest.swift
//  DemoLastFmTests
//
//  Created by Surendra on 20/06/2020.
//  Copyright © 2020 Surendra. All rights reserved.
//

import XCTest
@testable import LastFmDemo

class RequestQueryBuilderTest: XCTestCase {
    
    func testRequestBuilderForSearch() {
        let searchRequestBuilder = RequestQueryBuilder.searchAlbum(searchTerm: "Believe", page: 1)
        let queryItems = searchRequestBuilder.queryItems
        
        XCTAssert(queryItems.count == 5, "There must be 5 query ttems")
        XCTAssert((queryItems[0].name == "method" && queryItems[0].value == "album.search"), "1 query item (name = 'method', value ='album')")
        XCTAssert((queryItems[1].name == "album" && queryItems[1].value == "Believe"), "2nd query item (name = 'album', value = 'Believe')")
        XCTAssert((queryItems[2].name == "api_key" && queryItems[2].value == "d1fc847c81855b6b8c7f340f7f7f00a1"), "3rd query item (name = 'api_key', value = 'd1fc847c81855b6b8c7f340f7f7f00a1')")
        XCTAssert((queryItems[3].name == "page" && queryItems[3].value == "1"), "4nd query item (name = 'page', value = '1')")
        XCTAssert((queryItems[4].name == "format" && queryItems[4].value == "json"), "5th query item (name = 'format', value = 'json')")
        
        let url = searchRequestBuilder.request()
        XCTAssert(url != nil, "There must be url")
        
        let urlString = "http://ws.audioscrobbler.com/2.0/?method=album.search&album=Believe&api_key=d1fc847c81855b6b8c7f340f7f7f00a1&page=1&format=json"
        if let _ = url {
            XCTAssert(url?.absoluteString == urlString, "Url string must be \(urlString)")
        }
    }
    
}

//
//  AlbumsListViewModelTests.swift
//  DemoLastFmTests
//
//  Created by Surendra on 20/06/2020.
//  Copyright © 2020 Surendra. All rights reserved.
//

import XCTest
@testable import LastFmDemo

class AlbumsListViewModelTests: XCTestCase {
    
    
    var albumsListViewModelDelegateMock: AlbumsListViewModelDelegateMock!
    
    override func setUp() {
        albumsListViewModelDelegateMock = AlbumsListViewModelDelegateMock()
    }
    
    override func tearDown() {
        albumsListViewModelDelegateMock = nil
    }
    
    
    func testSettingSearchTerm() {
        var viewModel: AlbumsListViewModelProtocol = AlbumsListViewModel(withDelegate: albumsListViewModelDelegateMock)
        
        viewModel.searchTerm = "Believe"
        
        wait(for: 2)
        
        XCTAssert(viewModel.currentCount == 50, "There must be 50 albums in search")
        XCTAssert(viewModel.alubm(atIndex: 0)?.name == "Believe", "First album's name shoud be 'Believe'")
        XCTAssert(viewModel.alubm(atIndex: 0)?.artist == "Disturbed", "First album's artist shoud be 'Disturbed'")
        XCTAssert(viewModel.alubm(atIndex: 51) == nil, "There should be only 50 albums")
        XCTAssert(albumsListViewModelDelegateMock.onFetchCompletedCalled == true, "onFetchCompleted function must be called")
        
    }
    
    
    func testPaging() {
        
        var viewModel: AlbumsListViewModelProtocol = AlbumsListViewModel(withDelegate: albumsListViewModelDelegateMock)
        viewModel.searchTerm = "Believe"
        
        wait(for: 2)
        
        XCTAssert(viewModel.currentCount == 50, "There must be 50 albums in search")
        XCTAssert(viewModel.alubm(atIndex: 0)?.name == "Believe", "First album's name shoud be 'Believe'")
        XCTAssert(viewModel.alubm(atIndex: 0)?.artist == "Disturbed", "First album's artist shoud be 'Disturbed'")
        XCTAssert(albumsListViewModelDelegateMock.onFetchCompletedCalled == true, "onFetchCompleted function must be called")
        
        //test for fetching next page page = 2
        albumsListViewModelDelegateMock.onFetchCompletedCalled = false
        viewModel.fetchAlbums()
        
        wait(for: 2)
        
        XCTAssert(viewModel.currentCount == 100, "There must be 100 albums in search")
        XCTAssert(albumsListViewModelDelegateMock.onFetchCompletedCalled == true, "onFetchCompleted function must be called")
        
        //test for fetching next page page = 3
        albumsListViewModelDelegateMock.onFetchCompletedCalled = false
        viewModel.fetchAlbums()
        
        wait(for: 2)
        
        XCTAssert(viewModel.currentCount == 150, "There must be 150 albums in search")
        XCTAssert(albumsListViewModelDelegateMock.onFetchCompletedCalled == true, "onFetchCompleted function must be called")
    }
    
    func testValidSearchTerm()  {
        let viewModel: AlbumsListViewModelProtocol = AlbumsListViewModel(withDelegate: albumsListViewModelDelegateMock)
        XCTAssert(viewModel.isValidSearchTerm("A") == false, "Search term shold has atleast 3 characters")
        
        XCTAssert(viewModel.isValidSearchTerm("   A") == false, "Search term shold has atleast 3 characters")
        
        XCTAssert(viewModel.isValidSearchTerm("A    ") == false, "Search term shold has atleast 3 characters")
        
        XCTAssert(viewModel.isValidSearchTerm(" A  ") == false, "Search term shold has atleast 3 characters")
        
        XCTAssert(viewModel.isValidSearchTerm("Bel") == true, "'Bel' is valid search term")
    }
    
    func testException() {
        let exception = CustomError.dataNotFoundError
        let dataServiceMock = DataServiceProviderMock(withSuceess: nil, exception: exception)
        
        var viewModel: AlbumsListViewModelProtocol = AlbumsListViewModel(withDelegate: albumsListViewModelDelegateMock, dataService: dataServiceMock)
        viewModel.searchTerm = "Believe"
        
        wait(for: 2)
        
        XCTAssert(albumsListViewModelDelegateMock.onFetchFailedCalled == true, "onFetchFailed function must be called")
        XCTAssert(albumsListViewModelDelegateMock.exception != nil, "there must be an exceptino")
        if albumsListViewModelDelegateMock.exception != nil {
            XCTAssert(albumsListViewModelDelegateMock.exception!.localizedDescription == exception.localizedDescription, "Exception must be CustomError.dataNotFoundError")
        }
        
    }
}


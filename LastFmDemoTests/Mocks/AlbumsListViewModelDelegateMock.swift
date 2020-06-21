//
//  AlbumsListViewModelDelegateMock.swift
//  DemoLastFmTests
//
//  Created by Surendra on 20/06/2020.
//  Copyright © 2020 Surendra. All rights reserved.
//

@testable import LastFmDemo

class AlbumsListViewModelDelegateMock: AlbumsListViewModelDelegate {
    
    var onFetchCompletedCalled = false
    var onFetchFailedCalled = false
    var didHandleMemoryWarningCalled = false
    var exception: Error?
    
    func onFetchCompleted() {
        onFetchCompletedCalled = true
    }
    
    func onFetchFailed(with error: Error) {
        onFetchFailedCalled = true
        exception = error
    }

    func didHandleMemoryWarning() {
        didHandleMemoryWarningCalled = true
    }

}

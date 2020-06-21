//
//  AlbumsListViewModelDelegateMock.swift
//  DemoLastFmTests
//
//  Created by Surendra on 20/06/2020.
//  Copyright © 2020 Surendra. All rights reserved.
//

@testable import LastFmDemo

class AlbumsListViewModelDelegateMock {
    
    private(set) var onFetchCompletedCalled = false
    private(set) var onFetchFailedCalled = false
    private(set) var didHandleMemoryWarningCalled = false
    private(set) var exception: Error?
    
    
    func resetValues() {
        onFetchCompletedCalled = false
        onFetchFailedCalled = false
        didHandleMemoryWarningCalled = false
        exception = nil
    }
}

extension AlbumsListViewModelDelegateMock: AlbumsListViewModelDelegate {
    
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

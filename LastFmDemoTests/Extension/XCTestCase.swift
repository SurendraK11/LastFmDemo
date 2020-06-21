//
//  XCTestCase.swift
//  LastFmDemoTests
//
//  Created by Surendra on 21/06/2020.
//  Copyright © 2020 Surendra. All rights reserved.
//

import XCTest

extension XCTestCase {
    
    func wait(for duration: TimeInterval) {
        
        let waitExpectation = expectation(description: "Waiting")
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
            waitExpectation.fulfill()
        }
        
        waitForExpectations(timeout: duration + 0.5)
    }
}

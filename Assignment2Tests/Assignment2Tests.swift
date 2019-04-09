//
//  Assignment2Tests.swift
//  Assignment2Tests
//
//  Created by Min young Go on 9/4/19.
//  Copyright © 2019 Min young Go. All rights reserved.
//

import XCTest
@testable import Assignment2

class Assignment2Tests: XCTestCase {

    override func setUp() {
        
        _ = Location(name: "Brisbane", address: "Sydeny", long: 153.0282252, lat: -27.4635654)
        _ = Location(name: "Sydney", address: "Sydney", long: 153.0282252, lat: -33.8727496)
        _ = Location(name: "test", address: "12", long: 35.7102702 , lat: 32.9845976)

       


        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

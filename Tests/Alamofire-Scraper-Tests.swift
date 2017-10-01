//
//  Alamofire-Scraper-Tests.swift
//  Alamofire-Scraper-Tests
//
//  Created by Aaron Lee on 2017-09-30.
//  Copyright (c) 2017 Aaron Lee. All rights reserved.
//

import XCTest
import Alamofire
import AlamofireScraper

class Alamofire_ScraperTests: XCTestCase {
    
    func testGETRequestHTMLResponse() {
        let URL = "https://www.w3schools.com"
        let expect = expectation(description: "responseHTML method should work")
        Alamofire.request(URL, method: .get, parameters: nil, encoding: URLEncoding.default)
            .validate()
            .responseHTML(scrapeBy: "a.w3-bar-item") { response in
                XCTAssertNotNil(response.request, "request should not be nil")
                XCTAssertNotNil(response.response, "response should not be nil")
                XCTAssertNil(response.error, "result error should be nil")
                XCTAssertEqual(response.value?[6], "Learn HTML", "result should be equal to test string")
                expect.fulfill()
        }
        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
}

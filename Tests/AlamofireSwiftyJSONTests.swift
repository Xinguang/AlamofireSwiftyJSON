//
//  AlamofireSwiftyJSONTests.swift
//  AlamofireSwiftyJSONTests
//
//  Created by Hikaru on 2016/01/30.
//  Copyright © 2016年 Hikaru. All rights reserved.
//

import XCTest
import Alamofire
import SwiftyJSON
import AlamofireSwiftyJSON

class AlamofireSwiftyJSONTests: XCTestCase {
    
    func testJSONResponse() {
        let URL = "http://httpbin.org/get"
        let expectation = expectationWithDescription("\(URL)")
        
        Alamofire.request(.GET, URL, parameters: ["foo": "bar"]).responseSwiftyJSON { response in
            
            print("###Success: \(response.result.isSuccess)")
            print("###Response String: \(response.result.value)")
            
            expectation.fulfill()
            XCTAssertNotNil(response.request, "request should not be nil")
            XCTAssertNotNil(response.response, "response should not be nil")
            XCTAssertTrue(response.result.error == nil, "result error should be nil")
            XCTAssertEqual(response.result.value?["args"], SwiftyJSON.JSON(["foo": "bar"] as NSDictionary), "args should be equal")
        }
        waitForExpectationsWithTimeout(10) { error in
            XCTAssertNil(error, "\(error)")
        }
    }
    
}

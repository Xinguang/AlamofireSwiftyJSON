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
        let parameters = ["foo": "bar"]
        Alamofire.request(.GET, URL, parameters: parameters).responseSwiftyJSON { response in

//            print("###Success: \(response.result.isSuccess)")
//            print("###Response String: \(response.result.value)")
//            print("###Response Type: \(response.result.value.dynamicType)")

            expectation.fulfill()
            XCTAssertNotNil(response.request, "request should not be nil")
            XCTAssertNotNil(response.response, "response should not be nil")
            XCTAssertTrue(response.result.error == nil, "result error should be nil")
            let jsonParameters = SwiftyJSON.JSON(parameters)
            XCTAssertEqual(response.result.value?["args"], jsonParameters, "args should be equal")
        }
        waitForExpectationsWithTimeout(10) { error in
            XCTAssertNil(error, "\(error)")
        }
    }

}

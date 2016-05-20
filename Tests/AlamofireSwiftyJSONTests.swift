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

    func testJSONResponseSerializer() {
        let serializer = Request.SwiftyJSONResponseSerializer(options: .AllowFragments)

        let error = NSError(domain: "AlamofireSwiftyJSON.test", code: 1, userInfo: ["key": "value"])
        let errorResult = serializer.serializeResponse(nil, nil, nil, error)
        XCTAssertEqual(errorResult.error, error, "args should be equal")

        let response = NSHTTPURLResponse(URL: NSURL(), statusCode: 204,
                                         HTTPVersion: nil, headerFields: nil)
        let responseResult = serializer.serializeResponse(nil, response, nil, nil)
        XCTAssertEqual(responseResult.value, JSON.null, "args should be equal")

        let data = NSData()
        let nodataResult = serializer.serializeResponse(nil, nil, data, nil)
        let errCode = Error.Code.JSONSerializationFailed.rawValue
        XCTAssertEqual(nodataResult.error?.code, errCode, "args should be equal")

        let encode = NSUTF8StringEncoding

        let str = "{\"foo\": \"bar\"}"
        let validData = str.dataUsingEncoding(encode, allowLossyConversion: false)!
        let dataResult = serializer.serializeResponse(nil, nil, validData, nil)
        XCTAssertEqual(dataResult.value, ["foo": "bar"], "args should be equal")

        let novalidData = "foo".dataUsingEncoding(encode, allowLossyConversion: false)!
        let novalidDataResult = serializer.serializeResponse(nil, nil, novalidData, nil)
        XCTAssertNotNil(novalidDataResult.error, "error should not be nil")

    }

}

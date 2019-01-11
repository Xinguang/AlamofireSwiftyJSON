//
//  AlamofireSwiftyJSONTests.swift
//  AlamofireSwiftyJSONTests
//
//  Created by Hikaru on 2016/01/30.
//  Copyright (c) 2016 Hikaru. All rights reserved.
//

import XCTest
import Alamofire
import SwiftyJSON

import AlamofireSwiftyJSON

private func httpURLResponse(statusCode: Int, headers: HTTPHeaders = [:]) -> HTTPURLResponse {
    let url = URL(string: "https://httpbin.org/get")!
    return HTTPURLResponse(url: url,
                           statusCode: statusCode,
                           httpVersion: "HTTP/1.1",
                           headerFields: headers)!
}

private func getResult(response: HTTPURLResponse?, data: Data?, error: Error?) -> Result<JSON> {
    return Request.serializeResponseSwiftyJSON(
                        options: .allowFragments,
                        response: response,
                        data: data,
                        error: error)
}

class AlamofireSwiftyJSONTests: XCTestCase {

    // MARK: Tests - Data Response Serializer

    func testJSONResponse() {
        let URL = "http://httpbin.org/get"
        let expectation = self.expectation(description: "\(URL)")
        let parameters = ["foo": "bar"]

        Alamofire.request(URL, method: .get, parameters: parameters)
            .responseSwiftyJSON { response in
                expectation.fulfill()
                XCTAssertNotNil(response.request, "request should not be nil")
                XCTAssertNotNil(response.response, "response should not be nil")
                XCTAssertTrue(response.result.error == nil, "result error should be nil")
                let jsonParameters = SwiftyJSON.JSON(parameters)
                let args = response.result.value?["args"]
                XCTAssertEqual(args, jsonParameters, "args should be equal")
            }
        waitForExpectations(timeout: 10) { error in
            XCTAssertNil(error, String(describing: error))
        }
    }

    func testThatDataResponseSerializerFailsWhenErrorIsNotNil() {
        // Given
        let error = AFError.responseSerializationFailed(reason: .inputDataNil)
        // When
        let result = getResult(response: nil, data: nil, error: error)

        // Then
        XCTAssertTrue(result.isFailure)
        XCTAssertNil(result.value)
        XCTAssertNotNil(result.error)

        if let error = result.error as? AFError {
            XCTAssertTrue(error.isResponseSerializationError)
        } else {
            XCTFail("error should not be nil")
        }
    }

    func testThatDataResponseSerializerSucceedsWhenDataIsNilWithEmptyResponseStatusCode204() {
        // Given
        let response = httpURLResponse(statusCode: 204)

        // When
        let result = getResult(response: response, data: nil, error: nil)

        // Then
        XCTAssertTrue(result.isSuccess)
        XCTAssertNotNil(result.value)
        XCTAssertNil(result.error)

        if let data = result.value {
            XCTAssertEqual(data.count, 0)
        }
    }

    func testThatDataResponseSerializerSucceedsWhenDataIsNilWithEmptyResponseStatusCode205() {
        // Given
        let response = httpURLResponse(statusCode: 205)

        // When
        let result = getResult(response: response, data: nil, error: nil)

        // Then
        XCTAssertTrue(result.isSuccess)
        XCTAssertNotNil(result.value)
        XCTAssertNil(result.error)

        if let data = result.value {
            XCTAssertEqual(data.count, 0)
        }
    }

    func testThatDataResponseSerializerFailsWhenDataIsNilWithNonEmptyResponseStatusCode() {
        // Given
        let response = httpURLResponse(statusCode: 200)

        // When
        let result = getResult(response: response, data: nil, error: nil)

        // Then
        XCTAssertTrue(result.isFailure, "result is failure should be true")
        XCTAssertNil(result.value, "result value should be nil")
        XCTAssertNotNil(result.error, "result error should not be nil")

        if let error = result.error as? AFError {
            XCTAssertTrue(error.isResponseSerializationError)
        } else {
            XCTFail("error should not be nil")
        }
    }

    func testThatDataResponseSerializerFailsWhenDataIsEmptyWithNonEmptyResponseStatusCode() {
        // Given
        let response = httpURLResponse(statusCode: 200)

        // When
        let result = getResult(response: response, data: Data(), error: nil)

        // Then
        XCTAssertTrue(result.isFailure, "result is failure should be true")
        XCTAssertNil(result.value, "result value should be nil")
        XCTAssertNotNil(result.error, "result error should not be nil")

        if let error = result.error as? AFError {
            XCTAssertTrue(error.isResponseSerializationError)
        } else {
            XCTFail("error should not be nil")
        }
    }

    func testThatJSONResponseSerializerSucceedsWhenDataIsValidJSON() {
        // Given
        let data = "{\"json\": true}".data(using: .utf8)!

        // When
        let result = getResult(response: nil, data: data, error: nil)

        // Then
        XCTAssertTrue(result.isSuccess)
        XCTAssertNotNil(result.value)
        XCTAssertNil(result.error)
    }

    func testThatJSONResponseSerializerFailsWhenDataIsInvalidJSON() {
        // Given
        let data = "definitely not valid json".data(using: .utf8)!

        // When
        let result = getResult(response: nil, data: data, error: nil)

        // Then
        XCTAssertTrue(result.isFailure)
        XCTAssertNil(result.value)
        XCTAssertNotNil(result.error)

        if let error = result.error as? AFError,
            let underlyingError = error.underlyingError as? CocoaError {
                XCTAssertTrue(error.isResponseSerializationError)
                XCTAssertEqual(underlyingError.errorCode, 3840)
        } else {
            XCTFail("error should not be nil")
        }
    }
}

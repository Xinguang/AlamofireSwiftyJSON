//
//  AlamofireSwiftyJSON.swift
//  AlamofireSwiftyJSON
//
//  Created by Hikaru on 2016/01/29.
//  Copyright © 2016年 Hikaru. All rights reserved.
//

import Foundation

import Alamofire
import SwiftyJSON

// MARK: - Request for Swift JSON

extension Request {
    /**
     Adds a handler to be called once the request has finished.

     - parameter queue:             The queue on which the completion handler is dispatched.
     - parameter options:           The JSON serialization reading options.
                                    `.AllowFragments` by default.
     - parameter completionHandler: A closure to be executed once the request has finished.

     - returns: The request.
     */
    public func responseSwiftyJSON(
        queue: dispatch_queue_t? = nil,
        options: NSJSONReadingOptions = .AllowFragments,
        completionHandler: Response<JSON, NSError> -> Void)
        -> Self {
            return response(
                queue: queue,
                responseSerializer: Request.SwiftyJSONResponseSerializer(options: options),
                completionHandler: completionHandler
            )
    }

    /**
     Creates a response serializer that returns a SwiftyJSON object constructed
     from the response data using `NSJSONSerialization`
     with the specified reading options.

     - parameter options: The SwiftyJSON serialization reading options.
                          `.AllowFragments` by default.

     - returns: A SwiftyJSON object response serializer.
     */
    public static func SwiftyJSONResponseSerializer(
        options options: NSJSONReadingOptions = .AllowFragments)
        -> ResponseSerializer<JSON, NSError> {
        return ResponseSerializer { _, response, data, error in
            guard error == nil else { return .Failure(error!) }

            if let response = response where response.statusCode == 204 {
                return .Success(JSON.null)
            }

            guard let validData = data where validData.length > 0 else {
                let failureReason = "JSON could not be serialized. " +
                "Input data was nil or zero length."
                let userInfo = [NSLocalizedFailureReasonErrorKey: failureReason]
                let code = Error.Code.JSONSerializationFailed.rawValue
                let e = NSError(domain: Error.Domain, code: code, userInfo: userInfo)
                return .Failure(e)
            }

            do {
                let json = try NSJSONSerialization.JSONObjectWithData(validData, options: options)

                return .Success(JSON(json))
            } catch {
                return .Failure(error as NSError)
            }
        }
    }

}

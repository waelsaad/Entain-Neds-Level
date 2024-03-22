//
//  HTTPStatusCode.swift
//  Neds
//
//  Created by Wael Saad on 17/3/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import Foundation

// An enumeration of all HTTP status codes and their corresponding descriptions.

enum HTTPStatusCode: Int {
    
    // 2xx Success
    // swiftlint:disable:next identifier_name
    
    case ok = 200

    // 4xx Client error
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case preconditionFail = 412
    case tooManyRequests = 429

    // 5xx Server error
    case serverError = 500
    case serviceUnavailable = 503
    
}

//
//  RacingEndpoint.swift
//  Neds
//
//  Created by Wael Saad on 17/3/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import Foundation

// MARK: - This pattern allows us to easily add multiple methods to multiple endpoints.

// Define an enum to represent different racing endpoints.

enum RacingEndpoint {
    case nextRaces(count: Int) // Define a case for retrieving next races with a count parameter.
}

// Extend RacingEndpoint to conform to EndpointType protocol.

extension RacingEndpoint: EndpointType {
    
    // Define the path for each endpoint case.
    
    var path: String {
        switch self {
        case .nextRaces:
            return "racing/" // Path for retrieving next races.
        }
    }

    // Define the query parameters for each endpoint case.
    
    var query: [String: String] {
        switch self {
        case .nextRaces(let count):
            return [
                "method": "nextraces", // Specify the method for retrieving next races.
                "count": "\(count)" // Include the count parameter in the query.
            ]
        }
    }

    // Define the HTTP method for each endpoint case.
    
    var method: HTTPMethod {
        switch self {
        case .nextRaces:
            return .get // Use GET method for retrieving next races.
        }
    }

    // Define the HTTP headers for each endpoint case.
    
    var headers: HTTPHeaders? {
        switch self {
        case .nextRaces(_):
            return [:] // No specific headers needed for retrieving next races.
        }
    }
    
}

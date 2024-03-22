//
//  Endpoints.swift
//  Neds
//
//  Created by Wael Saad on 17/3/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import Foundation

// MARK: - Endpoint Configuration

enum Endpoint {

    // Nested enum for endpoint configuration constants.

    enum Configuration {
        
        static let kScheme = "https"
        static let kVersion = "/rest/v1/"
        static let kServerURL = "api.neds.com.au"
        static let kExpiryPeriod: Double = 60
        
    }

}

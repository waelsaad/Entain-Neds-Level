//
//  VenueCountry.swift
//  Neds
//
//  Created by Wael Saad on 17/3/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import Foundation

// MARK: - VenueCountry

enum VenueCountry: String, Codable {
    
    case aus = "AUS"
    case jpn = "JPN"
    case nz = "NZ"
    case unknown = "Unknown"

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        self = Self(rawValue: rawValue) ?? .unknown
    }
    
}

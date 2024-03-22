//
//  Weather.swift
//  Neds
//
//  Created by Wael Saad on 17/3/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import Foundation

// MARK: - Weather

struct Weather: Codable {
    
    let id: String
    let name: String
    let shortName: String
    let iconUri: String
    
}

extension Weather: Equatable {
    
    static func == (lhs: Weather, rhs: Weather) -> Bool {
        lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.shortName == rhs.shortName &&
        lhs.iconUri == rhs.iconUri
    }
    
}

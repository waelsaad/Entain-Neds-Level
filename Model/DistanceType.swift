//
//  DistanceType.swift
//  Neds
//
//  Created by Wael Saad on 17/3/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import Foundation

// MARK: - DistanceType

struct DistanceType: Codable {
    
    let id: String
    let name: String
    let shortName: String
    let iconURI: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case shortName = "short_name"
        case iconURI = "icon_uri"
    }
    
}

extension DistanceType: Equatable {
    
    static func == (lhs: DistanceType, rhs: DistanceType) -> Bool {
        lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.shortName == rhs.shortName &&
        lhs.iconURI == rhs.iconURI
    }
    
}

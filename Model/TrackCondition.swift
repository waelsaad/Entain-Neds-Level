//
//  TrackCondition.swift
//  Neds
//
//  Created by Wael Saad on 17/3/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import Foundation

// MARK: - TrackCondition

struct TrackCondition: Codable {
    
    let id: String
    let name: String
    let shortName: String?
    
}

extension TrackCondition: Equatable {
    
    static func == (lhs: TrackCondition, rhs: TrackCondition) -> Bool {
        lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.shortName == rhs.shortName
    }
    
}

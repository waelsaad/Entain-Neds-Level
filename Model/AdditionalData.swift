//
//  AdditionalData.swift
//  Neds
//
//  Created by Wael Saad on 17/3/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import Foundation

// MARK: - AdditionalData

struct AdditionalData: Codable {
    
    let revealedRaceInfo: RevealedRaceInfo
    
}

extension AdditionalData: Equatable {
    
    static func == (lhs: AdditionalData, rhs: AdditionalData) -> Bool {
        lhs.revealedRaceInfo == rhs.revealedRaceInfo
    }
    
}

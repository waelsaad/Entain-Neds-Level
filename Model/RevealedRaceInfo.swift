//
//  RevealedRaceInfo.swift
//  Neds
//
//  Created by Wael Saad on 17/3/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import Foundation

// MARK: - RevealedRaceInfo

struct RevealedRaceInfo: Codable {
    
    let trackName: String
    let state: String
    let country: String
    let number: Int
    let raceName: String
    let time: String
    let classInfo: String
    let startType: String
    let prizemonies: Prizemonies
    let railPosition: String
    let trackDirection: String
    let trackSurface: String
    let group: String
    
}

extension RevealedRaceInfo: Equatable {
    
    static func == (lhs: RevealedRaceInfo, rhs: RevealedRaceInfo) -> Bool {
        lhs.trackName == rhs.trackName &&
        lhs.state == rhs.state &&
        lhs.country == rhs.country &&
        lhs.number == rhs.number &&
        lhs.raceName == rhs.raceName &&
        lhs.time == rhs.time &&
        lhs.classInfo == rhs.classInfo &&
        lhs.startType == rhs.startType &&
        lhs.prizemonies == rhs.prizemonies &&
        lhs.railPosition == rhs.railPosition &&
        lhs.trackDirection == rhs.trackDirection &&
        lhs.trackSurface == rhs.trackSurface &&
        lhs.group == rhs.group
    }
    
}

//
//  RaceStartDate.swift
//  Neds
//
//  Created by Wael Saad on 17/3/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import Foundation

// MARK: - AdvertisedStart

struct AdvertisedStart: Codable, Hashable {

    let seconds: Double
    
}

extension AdvertisedStart {
    
    var date: Date {
        Date(timeIntervalSince1970: seconds)
    }
    
}

//
//  RaceResponse.swift
//  Neds
//
//  Created by Wael Saad on 17/3/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import Foundation

// MARK: - RaceResponse

struct RaceResponse: Codable {
    
    let status: Int
    let data: RaceData
    let message: String
    
}

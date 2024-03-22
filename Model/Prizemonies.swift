//
//  Prizemonies.swift
//  Neds
//
//  Created by Wael Saad on 17/3/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import Foundation

// MARK: - Prizemonies

struct Prizemonies: Codable {
    
    let first: Int?
    let second: Int?
    let third: Int?
    let fourth: Int?
    let fifth: Int?
    let totalValue: Int
    
}

extension Prizemonies: Equatable {
    
    static func == (lhs: Prizemonies, rhs: Prizemonies) -> Bool {
        lhs.first == rhs.first &&
        lhs.second == rhs.second &&
        lhs.third == rhs.third &&
        lhs.fourth == rhs.fourth &&
        lhs.fifth == rhs.fifth &&
        lhs.totalValue == rhs.totalValue
    }
    
}

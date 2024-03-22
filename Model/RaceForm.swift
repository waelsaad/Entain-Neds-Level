//
//  RaceResponse.swift
//  Neds
//
//  Created by Wael Saad on 17/3/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import Foundation

// MARK: - RaceForm

struct RaceForm: Codable {
    
    let distance: Int
    let distanceType: DistanceType
    let distanceTypeID: String
    let trackCondition: TrackCondition?
    let trackConditionID: String
    let weather: Weather?
    let weatherID: String?
    let raceComment, additionalData: String
    let generated: Int
    let silkBaseURL: SilkBaseURL
    let raceCommentAlternative: String

    enum CodingKeys: String, CodingKey {
        case distance
        case distanceType = "distance_type"
        case distanceTypeID = "distance_type_id"
        case trackCondition = "track_condition"
        case trackConditionID = "track_condition_id"
        case weather
        case weatherID = "weather_id"
        case raceComment = "race_comment"
        case additionalData = "additional_data"
        case generated
        case silkBaseURL = "silk_base_url"
        case raceCommentAlternative = "race_comment_alternative"
        
    }
}

extension RaceForm: Equatable {
    
    static func == (lhs: RaceForm, rhs: RaceForm) -> Bool {
        lhs.distance == rhs.distance &&
        lhs.distanceType == rhs.distanceType &&
        lhs.distanceTypeID == rhs.distanceTypeID &&
        lhs.trackCondition == rhs.trackCondition &&
        lhs.trackConditionID == rhs.trackConditionID &&
        lhs.weather == rhs.weather &&
        lhs.weatherID == rhs.weatherID &&
        lhs.raceComment == rhs.raceComment &&
        lhs.additionalData == rhs.additionalData &&
        lhs.generated == rhs.generated &&
        lhs.silkBaseURL == rhs.silkBaseURL &&
        lhs.raceCommentAlternative == rhs.raceCommentAlternative
    }
    
}

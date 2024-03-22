//
//  RaceSummary.swift
//  Neds
//
//  Created by Wael Saad on 17/3/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import Foundation

// MARK: - RaceSummary

let kRaceSummariesDisplayedTotal = 5

struct RaceSummary: Codable, Identifiable {
    
    let id = UUID()
    let raceID: String
    let raceName: String
    let raceNumber: Int
    let meetingID: String
    let meetingName: String
    let category: RaceCategory
    let advertisedStart: AdvertisedStart
    // let raceForm: RaceForm
    let venueID: String
    let venueName: String
    let venueState: String
    let venueCountry: VenueCountry
    
    enum CodingKeys: String, CodingKey {
        case raceID = "race_id"
        case raceName = "race_name"
        case raceNumber = "race_number"
        case meetingID = "meeting_id"
        case meetingName = "meeting_name"
        case category = "category_id"
        case advertisedStart = "advertised_start"
        // case raceForm = "race_form"
        case venueID = "venue_id"
        case venueName = "venue_name"
        case venueState = "venue_state"
        case venueCountry = "venue_country"
    }
    
}

extension RaceSummary {
    
    /// Label for the race summary.
    
    var label: String {
        "\(meetingName) • R\(raceNumber)"
    }
    
    /// Check if the race has already started.

    var isStarted: Bool { self.advertisedStart.seconds - Date().timeIntervalSince1970 < 0 }
    
    /// Check if the race is less than five minutes away.
        
    var isLessThanFiveMinutesAway: Bool {
        abs(self.advertisedStart.seconds - Date().timeIntervalSince1970) < Date.fiveMinutesInSeconds
    }
    
}

extension Array where Element == RaceSummary {
    
    /// Filter and sort race summaries and return only the top kRaceSummariesDisplayedTotal summaries.
    /// 1- Filter by valid race selected categories.
    /// 2- Filter by VenueCountry when isINTL is true.
    /// 3- Sort by advertised start date.
    /// 4- Take the top kRaceSummariesDisplayedTotal summaries.
    
    func filteredAndSorted(for selectedCategories: Set<RaceCategory>, isINTL: Bool) -> [RaceSummary] {
        var filteredSummaries = self.filter { selectedCategories.contains($0.category) }
        
        if isINTL == false {
            filteredSummaries = filteredSummaries.filter { $0.venueCountry == .aus }
        }
        
        return Array(
            filteredSummaries
                .sorted { $0.advertisedStart.date < $1.advertisedStart.date }
                .prefix(kRaceSummariesDisplayedTotal)
        )
    }
    
}

extension RaceSummary: Equatable {
    
    static func == (lhs: RaceSummary, rhs: RaceSummary) -> Bool {
        lhs.id == rhs.id &&
        lhs.raceID == rhs.raceID &&
        lhs.raceName == rhs.raceName &&
        lhs.raceNumber == rhs.raceNumber &&
        lhs.meetingID == rhs.meetingID &&
        lhs.meetingName == rhs.meetingName &&
        lhs.category == rhs.category &&
        lhs.advertisedStart == rhs.advertisedStart &&
        // lhs.raceForm == rhs.raceForm &&
        lhs.venueID == rhs.venueID &&
        lhs.venueName == rhs.venueName &&
        lhs.venueState == rhs.venueState &&
        lhs.venueCountry == rhs.venueCountry
    }
    
}

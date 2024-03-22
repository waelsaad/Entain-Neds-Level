//
//  RaceResponseMock.swift
//  Neds
//
//  Created by Wael Saad on 20/3/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import Foundation

@testable import Neds

enum RaceResponseMock {
    
    static let raceResponse1 = RaceResponse(
        status: 200,
        data: RaceData(
            nextToGoIds: ["1", "2"],
            raceSummaries: [
                "1": RaceSummary(raceID: "1", raceName: "Race 1", raceNumber: 1, meetingID: "1", meetingName: "Meeting 1", category: .horse, advertisedStart: AdvertisedStart(seconds: Date().timeIntervalSince1970 + 60), venueID: "1", venueName: "Venue 1", venueState: "State 1", venueCountry: .aus),
                "2": RaceSummary(raceID: "2", raceName: "Race 2", raceNumber: 2, meetingID: "2", meetingName: "Meeting 2", category: .greyhound, advertisedStart: AdvertisedStart(seconds: Date().timeIntervalSince1970 + 120), venueID: "2", venueName: "Venue 2", venueState: "State 2", venueCountry: .aus)
            ]
        ),
        message: "Success"
    )

    static let raceResponse2 = RaceResponse(
        status: 404,
        data: RaceData(nextToGoIds: [], raceSummaries: [:]),
        message: "Not Found"
    )
    
}

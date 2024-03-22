//
//  SummaryItemTests.swift
//  Neds
//
//  Created by Wael Saad on 20/3/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

@testable import Neds
import XCTest
import SwiftUI

final class SummaryItemTests: XCTestCase {

    func testGivenRaceSummary_WhenViewInitialized_ThenExpectedRaceNameDisplayed() {
        // Given
        let sampleRaceSummary = RaceSummary(
            raceID: "0e585683-ec46-4caa-b45c-0682a5f4bba9",
            raceName: "Tasbreeders Night 5Th April Plate (C1)",
            raceNumber: 1,
            meetingID: "ee3656cc-8c7e-4e01-a4eb-8344de47eddb",
            meetingName: "Launceston",
            category: .greyhound,
            advertisedStart: AdvertisedStart(seconds: Date().timeIntervalSince1970),
            venueID: "377c03a4-6154-4b32-b8f0-ecfc8a6869ef",
            venueName: "Launceston",
            venueState: "TAS",
            venueCountry: .aus
        )
        let summaryItem = SummaryItem(raceSummary: sampleRaceSummary)

        // When
        let raceName = summaryItem.raceSummary.raceName

        // Then
        XCTAssertEqual(raceName, "Tasbreeders Night 5Th April Plate (C1)")
    }

    func testGivenRaceSummary_WhenViewInitialized_ThenExpectedTextColorSet() {
        // Given
        let sampleRaceSummary = RaceSummary(
            raceID: "0e585683-ec46-4caa-b45c-0682a5f4bba9",
            raceName: "Tasbreeders Night 5Th April Plate (C1)",
            raceNumber: 1,
            meetingID: "ee3656cc-8c7e-4e01-a4eb-8344de47eddb",
            meetingName: "Launceston",
            category: .greyhound,
            advertisedStart: AdvertisedStart(seconds: Date().timeIntervalSince1970),
            venueID: "377c03a4-6154-4b32-b8f0-ecfc8a6869ef",
            venueName: "Launceston",
            venueState: "TAS",
            venueCountry: .aus
        )
        let summaryItem = SummaryItem(raceSummary: sampleRaceSummary)

        // When
        let textColor = summaryItem.textColor

        // Then
        XCTAssertEqual(textColor, .red)
    }

}

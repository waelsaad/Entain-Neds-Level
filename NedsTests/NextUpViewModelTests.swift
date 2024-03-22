//
//  NedsTests.swift
//  Neds
//
//  Created by Wael Saad on 20/3/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

@testable import Neds
import XCTest
import Combine

final class NextUpViewModelTests: XCTestCase {
    
    // swiftlint:disable implicitly_unwrapped_optional
    
    private var viewModel: NextUpScene.NextUpViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = NextUpScene.NextUpViewModel()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        try super.tearDownWithError()
    }
    
    func testInitialState_WhenViewModelIsCreated_ShouldBeLoadingWithDefaultSettings() {
        XCTAssertEqual(viewModel.state, .loading)
        XCTAssertEqual(viewModel.selectedCategories, Set(RaceCategory.allCases))
        XCTAssertTrue(viewModel.isINTL)
    }
    
    func testFetchNextRaces_WhenViewModelFetchesRaces_ShouldReceiveExpectedRaces() {
        let expectation = XCTestExpectation(description: "Fetch Next Races")
        
        // Create a cancellable to track the completion of the operation
        var cancellable: AnyCancellable?
        
        // Default set of categories for testing purposes
        let selectedCategories: Set<RaceCategory> = [.horse, .greyhound, .harness]
        
        // Call the fetchNextRaces method and store the cancellable
        cancellable = viewModel.$state
            .sink { state in
                switch state {
                case .success(let raceSummaries):
                    // Filter and sort the first 5 elements of viewModel.raceSummaries
                    let filteredAndSortedViewModelRaceSummaries = self.viewModel.raceSummaries
                        .filteredAndSorted(for: selectedCategories, isINTL: true)
                    
                    // Compare the filtered and sorted first 5 elements
                    XCTAssertEqual(raceSummaries, filteredAndSortedViewModelRaceSummaries)
                    expectation.fulfill()
                case .loading, .failure:
                    break // Do nothing for loading or failure states
                }
            }
        
        // Trigger the fetchNextRaces method
        viewModel.fetchNextRaces(count: NextUpScene.NextUpViewModel.kRaceSummariesFetchedTotal)
        
        // Wait for the expectation to be fulfilled or timeout after 10 seconds
        wait(for: [expectation], timeout: 10)
        
        // Cancel the cancellable to avoid memory leaks
        cancellable?.cancel()
    }
    
    func testToggleINTLSelection_WhenToggled_ShouldChangeIsINTLState() {
        let initialValue = viewModel.isINTL
        viewModel.toggleINTLSelection()
        XCTAssertNotEqual(viewModel.isINTL, initialValue)
    }
    
    func testToggleCategorySelection_WhenToggled_ShouldChangeSelectedCategories() {
        let category = RaceCategory.horse
        
        // Deselect the category if it's already selected by default
        if viewModel.selectedCategories.contains(category) {
            viewModel.toggleCategorySelection(category)
        }
        
        let initialCategories = viewModel.selectedCategories
        viewModel.toggleCategorySelection(category)
        
        XCTAssertNotEqual(viewModel.selectedCategories, initialCategories)
        XCTAssertTrue(viewModel.selectedCategories.contains(category))
    }
    
    func testWhenUserDeselectsAllCategories_WhenAllCategoriesDeselected_ShouldResetCategoriesToDefault() {
        // Initialize the view model
        let viewModel = NextUpScene.NextUpViewModel()
        
        // Toggle the categories to ensure they are selected by default
        viewModel.toggleCategorySelection(.horse)
        viewModel.toggleCategorySelection(.greyhound)
        viewModel.toggleCategorySelection(.harness)
        
        // Now test the toggling behavior
        let categoriesToToggle: [RaceCategory] = [.horse, .greyhound, .harness]
        
        // Check that all categories are selected again
        for category in categoriesToToggle {
            XCTAssertTrue(viewModel.getSelectedCategoriesForTesting().contains(category))
        }
    }
    
    func testUpdateRaceSummariesIfNeeded_WhenSummaryNeedsUpdate_ShouldRemoveExpiredRace() {
        let race1 = RaceSummary(raceID: "1", raceName: "Race 1", raceNumber: 1, meetingID: "1", meetingName: "Meeting 1", category: .horse, advertisedStart: AdvertisedStart(seconds: Date().timeIntervalSince1970 + 120), venueID: "1", venueName: "Venue 1", venueState: "State 1", venueCountry: .aus)
        let race2 = RaceSummary(raceID: "2", raceName: "Race 2", raceNumber: 2, meetingID: "2", meetingName: "Meeting 2", category: .greyhound, advertisedStart: AdvertisedStart(seconds: Date().timeIntervalSince1970 - 120), venueID: "2", venueName: "Venue 2", venueState: "State 2", venueCountry: .jpn)
        
        viewModel.raceSummaries = [race1, race2]
        
        // Update race summaries
        viewModel.updateRaceSummariesIfNeeded()
        
        // Check if the expired race is removed
        XCTAssertFalse(viewModel.raceSummaries.contains { $0.raceID == "2" })
    }
    
}

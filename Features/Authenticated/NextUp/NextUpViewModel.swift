//
//  NextUpViewModel.swift
//  Neds
//
//  Created by Wael Saad on 17/3/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import SwiftUI
import Combine

extension NextUpScene {
    
    final class NextUpViewModel: ObservableObject {
        
        static let kRaceSummariesFetchedTotal = 10
        
        // MARK: Enum properties
        
        enum State: Equatable {
            case loading
            case success([RaceSummary])
            case failure(AppError)
            
            static func == (lhs: State, rhs: State) -> Bool {
                switch (lhs, rhs) {
                case (.loading, .loading):
                    return true
                case let (.success(lhsSummaries), .success(rhsSummaries)):
                    return lhsSummaries == rhsSummaries
                case let (.failure(lhsError), .failure(rhsError)):
                    return lhsError.localizedDescription == rhsError.localizedDescription
                default:
                    return false
                }
            }
        }
        
        // MARK: Exposed properties
        
        var raceSummaries: [RaceSummary] = []
        
        // MARK: Published properties
        
        @Published var isINTL = true
        
        @Published var showErrorView = false
        
        @Published var notificationsCount = 0
        
        @Published private(set) var state: State = .loading
 
        @Published private(set) var selectedCategories: Set<RaceCategory> = Set(RaceCategory.allCases)
        
        // MARK: Private properties
        
        private let raceService = RaceService()
        private var cancellables: Set<AnyCancellable> = []
        
        // MARK: Init
        
        init() {
            setupTimerForFetchingNextRaces()
            setupTimerForUpdatingRaceSummaries()
            fetchNextRaces(count: Self.kRaceSummariesFetchedTotal)
        }
        
        // MARK: Methods
        
        /// Fetches the next races from the server.
        
        func fetchNextRaces(count: Int) {
            raceService.nextRaces(count: count)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        self.showErrorView = true
                        let appError = self.handleError(error)
                        self.state = .failure(appError)
                        print("Error fetching next races:", appError.errorDescription)
                    case .finished:
                        print("Fetch next races completed successfully")
                    }
                }, receiveValue: { raceResponse in
                    self.showErrorView = false
                    let raceSummaries = raceResponse.data.raceSummaries.map { $0.value }
                    self.raceSummaries = raceSummaries
                    self.state = .success(self.raceSummaries.filteredAndSorted(for: self.selectedCategories, isINTL: self.isINTL))
                })
                .store(in: &cancellables) // Store the subscription to avoid memory leaks
        }
        
        // MARK: Race should disappear from the list after 1 min past the start time
        
        private func setupTimerForUpdatingRaceSummaries() {
            // Subscribe to a timer that emits a Date value every 1 second.
            Timer.every(Date.oneSecond)
            // Handle each emitted value by calling the updateRaceSummariesIfNeeded method.
                .sinkNext { [weak self] in
                    self?.updateRaceSummariesIfNeeded()
                }
            // Store the subscription in the cancellables set to manage its lifecycle.
                .store(in: &cancellables)
        }
        
        /// Sets up a timer to fetch next races every 60 seconds.
        
        private func setupTimerForFetchingNextRaces() {
            // Subscribe to a timer that emits a Date value every 60 seconds.
            Timer.every(Date.oneMinute)
            // Handle each emitted value by calling the fetchNextRaces method.
                .sinkNext { [weak self] in
                    self?.fetchNextRaces(count: Self.kRaceSummariesFetchedTotal)
                }
            // Store the subscription in the cancellables set to manage its lifecycle.
                .store(in: &cancellables)
        }
        
        // Schedule a timer to remove expired races after one minute
        
        private func removeExpiredRacesAfterOneMinute() {
            Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { [weak self] _ in
                guard let self = self else { return }
                self.updateRaceSummariesIfNeeded()
            }
        }
        
        // Update race summaries if needed based on the 1-minute past start time rule
        
        func updateRaceSummariesIfNeeded() {
            let now = Date().timeIntervalSince1970
            let updatedSummaries = self.raceSummaries.filter {
                $0.advertisedStart.seconds - now >= -Date.oneMinute
            }
            
            if updatedSummaries != self.raceSummaries {
                self.updateRaceSummaries(isINTL: isINTL, updatedSummaries)
            }
        }
        
        // Update the race summaries and set the state to success
        
        private func updateRaceSummaries(isINTL: Bool, _ updatedSummaries: [RaceSummary]) {
            self.raceSummaries = updatedSummaries
            self.state = .success(self.raceSummaries.filteredAndSorted(for: selectedCategories, isINTL: isINTL))
        }
        
        // Retry action closure to be triggered from ErrorView
        
        func retryAction() {
            fetchNextRaces(count: NextUpViewModel.kRaceSummariesFetchedTotal)
        }
    }
    
}

// MARK: Handles errors encountered during API request.

extension NextUpScene.NextUpViewModel {
    
    private func handleError(_ error: Error) -> AppError {
        switch error {
        case let appError as AppError:
            return appError
        case let urlError as URLError:
            return .noInternet(urlError)
        case let decodingError as DecodingError:
            return .decodingError(decodingError)
        default:
            return .genericError(error)
        }
    }
    
}

// MARK: Toggle INTL

extension NextUpScene.NextUpViewModel {
    
    // Method to toggle isINTL selection
    
    func toggleINTLSelection() {
        
        isINTL.toggle()
        
        // Update the race summaries after toggling isINTL selection
        updateRaceSummaries(isINTL: isINTL, raceSummaries)
    }

}

// MARK: Toggle Categories

extension NextUpScene.NextUpViewModel {
    
    // Method to toggle category selection
    func toggleCategorySelection(_ category: RaceCategory) {
        // Check if the last category is selected
        if isLastCategorySelected(category) {
            // If the last category is selected, select all categories
            selectAllCategories()
        } else {
            // Otherwise, toggle the selection of the specified category
            toggleCategory(category)
        }
        // Update the race summaries after toggling category selection
        updateRaceSummaries(isINTL: isINTL, raceSummaries)
    }

    // Helper function to check if the last category is selected
    private func isLastCategorySelected(_ category: RaceCategory) -> Bool {
        selectedCategories.count == 1 && selectedCategories.contains(category)
    }

    // Helper function to select all categories
    private func selectAllCategories() {
        selectedCategories = Set(RaceCategory.allCases)
    }

    // Helper function to toggle the selection of a category
    private func toggleCategory(_ category: RaceCategory) {
        if selectedCategories.contains(category) {
            // If the category is already selected, remove it
            selectedCategories.remove(category)
        } else {
            // If the category is not selected, add it
            selectedCategories.insert(category)
        }
    }
    
}

// MARK: Additional Methods used in Testing.

extension NextUpScene.NextUpViewModel {
    
    func getSelectedCategoriesForTesting() -> Set<RaceCategory> {
        selectedCategories
    }
    
    func getStateForTesting() -> NextUpScene.NextUpViewModel.State {
        state
    }
    
}

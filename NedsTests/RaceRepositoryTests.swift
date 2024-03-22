//
//  RaceRepositoryTests.swift
//  Neds
//
//  Created by Wael Saad on 20/3/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

@testable import Neds
import XCTest
import Combine

// swiftlint:disable force_cast

class RaceRepositoryTests: XCTestCase {

    // Mock API for testing purposes.
    
    private class MockAPI: API<RacingEndpoint> {
        override func request<T: Decodable>(_ endPoint: RacingEndpoint) -> AnyPublisher<T, AppError> {
            // For testing purposes, return a mock response.
            let mockResponse = RaceResponseMock.raceResponse1 as! T
            return Just(mockResponse)
                .setFailureType(to: AppError.self)
                .eraseToAnyPublisher()
        }
    }

    // Test the nextRaces method of RaceRepository.
    
    func testRaceRepositoryFetchingNextRacesWithMockAPI_ShouldReceiveValidResponse() {
        // Create a mock API instance.
        let mockAPI = MockAPI()
        // Create a race repository instance with the mock API.
        let raceRepository = RaceRepository(api: mockAPI)

        let count = 5
        let expectation = XCTestExpectation(description: "Next Races Request")

        // Make a request to fetch next races using the race repository.
        let cancellable = raceRepository.nextRaces(count: count)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail("Next races request failed with error: \(error.localizedDescription)")
                }
                expectation.fulfill()
            }, receiveValue: { response in
                // Assert that the response is of the expected type.
                XCTAssertEqual(response.status, 200)
                XCTAssertEqual(response.data.nextToGoIds.count, 2)
                XCTAssertEqual(response.data.raceSummaries.count, 2)
            })

        wait(for: [expectation], timeout: 10.0)

        // Cancel the request.
        cancellable.cancel()
    }
    
}

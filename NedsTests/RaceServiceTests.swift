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

class MockRaceRepository: RaceRepositoryProtocol {
    
    func nextRaces(count: Int) -> AnyPublisher<RaceResponse, AppError> {
        
        // Simulate a mock response for testing purposes.
        
        let mockResponse = RaceResponse(
            status: 200,
            data: RaceData(
                nextToGoIds: ["aa4c1dce-2bd9-498e-b329-bb8c20567a06", "0e585683-ec46-4caa-b45c-0682a5f4bba9"],
                raceSummaries: [:]
            ),
            message: "Mock Message"
        )
        return Just(mockResponse)
            .setFailureType(to: AppError.self)
            .eraseToAnyPublisher()
    }
    
}

class RaceServiceTests: XCTestCase {
    
    // swiftlint:disable implicitly_unwrapped_optional
    
    private var raceService: RaceService!
    private var mockRaceRepository: MockRaceRepository!

    override func setUp() {
        super.setUp()
        mockRaceRepository = MockRaceRepository()
        raceService = RaceService()
    }

    override func tearDown() {
        raceService = nil
        mockRaceRepository = nil
        super.tearDown()
    }

    // Test the nextRaces method of RaceService.
    
    func testFetchingNextRacesFromRaceService_WhenRepositoryReturnsMockResponse_ShouldReceiveMockedRaceResponse() {
        
        let count = 5
        let expectation = XCTestExpectation(description: "Next Races Request")

        let cancellable = raceService.nextRaces(count: count)
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
                // XCTAssertEqual(response.message, "Next 5 races from each category")
            })

        wait(for: [expectation], timeout: 5.0)

        // Cancel the request.
        cancellable.cancel()
        
    }
    
}

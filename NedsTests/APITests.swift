//
//  APITests.swift
//  Neds
//
//  Created by Wael Saad on 20/3/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

@testable import Neds
import XCTest
import Combine

// swiftlint:disable force_unwrapping

class APITests: XCTestCase {
    
    // Test the request method of API class.
    func testAPIRequest() {
        // Create a mock API instance with RacingEndpoint as the endpoint type.
        let mockAPI = API<RacingEndpoint>()
        
        // Create a RacingEndpoint instance for testing.
        let racingEndpoint = RacingEndpoint.nextRaces(count: 5)
        
        let expectation = XCTestExpectation(description: "Network Request")
        
        // Make a network request using the request method with the swizzled URLSession.
        let cancellable = mockAPI.request(racingEndpoint)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail("Network request failed with error: \(error.localizedDescription)")
                }
                expectation.fulfill()
            }, receiveValue: { (response: RaceResponse) in
                // Assert that the response is of the expected type.
                XCTAssertNotNil(response)
            })
        
        wait(for: [expectation], timeout: 10.0)
        
        // Cancel the network request.
        cancellable.cancel()
    }
    
}

// Helper struct for mocked data

enum MockData {
    static let mockedData = """
        {
            "id": 1,
            "title": "Mock Title"
        }
        """.data(using: .utf8)!
}

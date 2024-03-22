//
//  RaceRepository.swift
//  Neds
//
//  Created by Wael Saad on 17/3/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import Foundation
import Combine

/// Define a protocol for a race repository that fetches next races.

protocol RaceRepositoryProtocol {
    func nextRaces(count: Int) -> AnyPublisher<RaceResponse, AppError> // Define a method to fetch next races.
}

/// Implement the race repository protocol.

class RaceRepository: RaceRepositoryProtocol {
    
    private var api: API<RacingEndpoint> // Create an instance of API using RacingEndpoint.

    /// Initialize the race repository with an optional API instance (defaults to a new instance).
    
    init(api: API<RacingEndpoint> = API<RacingEndpoint>()) {
        self.api = api
    }
    
    /// Implement the method to fetch next races using the API.
    
    func nextRaces(count: Int) -> AnyPublisher<RaceResponse, AppError> {
        api.request(.nextRaces(count: count)) // Make a request to fetch next races using the API.
    }

}

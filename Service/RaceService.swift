//
//  RaceService.swift
//  Neds
//
//  Created by Wael Saad on 17/3/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import Foundation
import Combine

// Define a class responsible for handling race-related services.

class RaceService {
    
    private let raceRepository: RaceRepositoryProtocol // Declare a private property for the race repository.

    // Initialize the race service with a default implementation of the race repository.
    
    // TODO: inject RaceRepositoryProtocol in init for testing purposes
    
    required init() {
        raceRepository = RaceRepository()
    }
    
    // Define a method to fetch next races using the race repository.
    
    func nextRaces(count: Int) -> AnyPublisher<RaceResponse, AppError> {
        raceRepository.nextRaces(count: count) // Call the nextRaces method of the race repository.
            .eraseToAnyPublisher() // Erase the specific publisher type and return an AnyPublisher.
    }

}

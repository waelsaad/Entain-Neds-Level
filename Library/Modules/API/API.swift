//
//  VenueCountry.swift
//  Neds
//
//  Created by Wael Saad on 17/3/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import Foundation
import Combine

protocol APIProtocol {
    // Define a protocol with an associated type for the API endpoints.
    associatedtype Endpoint: EndpointType
    // Define a method to make a network request and return a publisher.
    func request<T: Decodable>(_ endPoint: Endpoint) -> AnyPublisher<T, AppError>
}

class API<Endpoint: EndpointType>: APIProtocol {
    
    func request<T: Decodable>(_ endPoint: Endpoint) -> AnyPublisher<T, AppError> {
        // Make a network request using URLSession dataTaskPublisher.
        URLSession.shared.dataTaskPublisher(for: endPoint.baseURL)
            .mapError { error -> AppError in
                // Map URLSession errors to AppError.noInternet case.
                AppError.noInternet(error)
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                // Decode the received data into the specified type T using JSONDecoder.
                Just(pair.data)
                    .decode(type: T.self, decoder: JSONDecoder())
                    .mapError { error -> AppError in
                        // Map decoding errors to AppError.decodingError case.
                        if let decodingError = error as? DecodingError {
                            return AppError.decodingError(decodingError)
                        } else {
                            // Map other errors to AppError.genericError case.
                            return AppError.genericError(error)
                        }
                    }
            }
            .receive(on: DispatchQueue.main) // Receive the result on the main DispatchQueue.
            .eraseToAnyPublisher() // Erase the type to AnyPublisher to hide implementation details.
    }
    
}

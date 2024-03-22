//
//  Timer+.swift
//  Library
//
//  Created by Wael Saad on 10/8/2022.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import SwiftUI
import Combine

extension Timer {
    
    // Extension to create a publisher that emits a Date value every specified interval.
    static func every(_ interval: TimeInterval) -> AnyPublisher<Date, Never> {
        // Using Combine's Timer.publish method to create a publisher that emits values based on the timer interval.
        Timer.publish(every: interval, on: .main, in: .common)
            // Autoconnect the publisher to start emitting values immediately.
            .autoconnect()
            // Erase the specific publisher type to AnyPublisher for more flexibility.
            .eraseToAnyPublisher()
    }
    
}

extension Publisher where Output == Date, Failure == Never {
    
    // Extension to simplify the sink operation by directly handling the next value emitted by the publisher.
    func sinkNext(_ action: @escaping () -> Void) -> AnyCancellable {
        // Use the sink method to subscribe to the publisher and handle the next value emitted.
        sink { _ in
            // Execute the provided action when a new value is received from the publisher.
            action()
        }
    }
    
}

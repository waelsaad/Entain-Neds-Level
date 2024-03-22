//
//  Date+.swift
//  Library
//
//  Created by Wael Saad on 20/6/2022.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import Foundation

// MARK: - Time Intervals

extension Date {
        
    // Constants representing time intervals in seconds.
    
    static let oneSecond: TimeInterval = 1
    
    static let oneMinute: TimeInterval = 60
    
    static let fiveMinutesInSeconds: TimeInterval = 5 * oneMinute
    
}

// MARK: - Date Formatting

extension Date {

    // Returns a formatted string representing the time difference from the current date to self
    
    var formattedString: String {
        
        // Calculate the time difference in seconds between self and the current date
        
        let timeDifference = self.timeIntervalSinceNow
        let absoluteDifference = abs(timeDifference)
        
        // Configure the DateComponentsFormatter for abbreviated style
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        
        // Check if the time difference is less than 5 minutes (300 seconds)
        if absoluteDifference < Date.fiveMinutesInSeconds {
            // If less than 5 minutes, allow units for minutes and seconds
            formatter.allowedUnits = [.minute, .second]
        } else {
            // If 5 minutes or more, allow units for minutes only
            formatter.allowedUnits = [.minute]
        }
        
        // Format the time difference using the configured DateComponentsFormatter
        let formattedString = formatter.string(from: absoluteDifference) ?? ""
        
        // Add "-" prefix to represent negative time differences
        if timeDifference < 0 {
            return "-" + formattedString
        } else {
            return formattedString
        }
    }
    
}

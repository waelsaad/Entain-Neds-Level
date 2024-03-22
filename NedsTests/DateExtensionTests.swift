//
//  DateExtensionTests.swift
//  Neds
//
//  Created by Wael Saad on 20/3/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

@testable import Neds
import XCTest

class DateExtensionTests: XCTestCase {
    
    // swiftlint:disable force_unwrapping
    
    func testFormattedStringWithinFiveMinutes() {
        // Create a date object representing the current date and time
        let currentDate = Date()
        
        // Create a date object representing 3 minutes and 30 seconds in the past
        let pastDate = Calendar.current.date(byAdding: .second, value: -210, to: currentDate)!
        
        // Call the formattedString property on the past date
        let formattedString = pastDate.formattedString
        
        // Assert that the formatted string contains both minutes and seconds
        XCTAssertTrue(formattedString.contains("3m 30s"))
    }
    
    func testFormattedStringFiveMinutesOrMore() {
        // Create a date object representing the current date and time
        let currentDate = Date()
        
        // Create a date object representing 10 minutes and 30 seconds in the past
        let pastDate = Calendar.current.date(byAdding: .second, value: -(10 * 60 + 30), to: currentDate)!
        
        // Call the formattedString property on the past date
        let formattedString = pastDate.formattedString
        
        // Assert that the formatted string contains only minutes
        XCTAssertTrue(formattedString.contains("10m"))
        XCTAssertFalse(formattedString.contains("30s")) // Assert that seconds are not present
    }
    
    func testFormattedStringSecondsOnly() {
        // Create a date object representing 45 seconds in the past
        let pastDate = Calendar.current.date(byAdding: .second, value: -45, to: Date())!
        
        // Call the formattedString property on the past date
        let formattedString = pastDate.formattedString
        
        // Assert that the formatted string contains only seconds
        XCTAssertTrue(formattedString.contains("45s"))
        XCTAssertFalse(formattedString.contains("m")) // Assert that minutes are not present
    }
    
    func testFormattedStringMinutesAndSeconds() {
        // Create a date object representing 3 minutes and 45 seconds in the past
        let pastDate = Calendar.current.date(byAdding: .second, value: -(3 * 60 + 45), to: Date())!
        
        // Call the formattedString property on the past date
        let formattedString = pastDate.formattedString
        
        // Assert that the formatted string contains both minutes and seconds
        XCTAssertTrue(formattedString.contains("3m"))
        XCTAssertTrue(formattedString.contains("45s"))
    }

}

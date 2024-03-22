//
//  AppError.swift
//  Neds
//
//  Created by Wael Saad on 17/3/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import SwiftUI

enum AppError: Error {
    
    case notFound
    case sessionExpired
    case noInternet(URLError)
    case decodingError(DecodingError)
    case genericError(Error)
    
    /// Return a human-readable description of the error.
    
    var errorDescription: String {
        switch self {
        case .notFound:
            return "Not found"
        case .sessionExpired:
            return "Session Expired."
        case .noInternet(let error):
            return "No internet connection. Error: \(error.localizedDescription)"
        case .decodingError(let error):
            return handleDecodingError(error)
        case .genericError(let error):
            return "An error occurred. Error: \(error.localizedDescription)"
        }
        
    }
    
    /// Return a localized string key for the error. We use this to display to the user

    var localized: LocalizedStringKey {
        switch self {
        case .notFound:
            return LocalizedStringKey("Not found")
        case .sessionExpired:
            return LocalizedStringKey("Session Expired.")
        case .noInternet(let error):
            return LocalizedStringKey(error.localizedDescription)
        case .decodingError(let error):
            return LocalizedStringKey(error.localizedDescription)
        case .genericError:
            return LocalizedStringKey("Unknown error")
        }
    }
    
    /// Helper method to handle DecodingErrors and return a descriptive message.
    /// This is used mainly to help us figuer out what went wrong with the decoding.
    
    func handleDecodingError(_ error: DecodingError) -> String {
        switch error {
        case .typeMismatch(let type, let context):
            return "Type mismatch error: \(type), context: \(context.debugDescription)"
        case .valueNotFound(let type, let context):
            return "Value not found error: \(type), context: \(context.debugDescription)"
        case .keyNotFound(let key, let context):
            return "Key not found error: \(key.stringValue), context: \(context.debugDescription)"
        case .dataCorrupted(let context):
            return "Data corrupted error, context: \(context.debugDescription)"
        @unknown default:
            return "Data corrupted unknown error"
        }
    }
    
}

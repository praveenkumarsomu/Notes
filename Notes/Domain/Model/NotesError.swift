//
//  NotesError.swift
//  Notes
//
//  Created by Praveen on 21/3/21.
//

import Foundation

/// Different possible errors for this appication we can add more here if needed in future
enum NotesError: Error {
    /// If notes`id` is not found in fire store DB
    case idNotFound(message: String = "Id not found")
    /// Generic error message
    case genericError(message: String = "Something went wrong please try again later")
    /// Error thrown by FireStore
    case serverError(String)
    
    /// Returns the error message to display in Alert
    /// - Returns: Retitns `String ` value that will be shown as Alert message 
    func getMessage() -> String {
        switch self {
        case .genericError(let message):
            return message
        case .serverError(let message):
            return message
        case .idNotFound(let message):
            return message
        @unknown default: break
        }
    }
}

//
//  Untitled.swift
//  FirebaseExample
//
//  Created by Richard Moult on 21/10/2025.
//

import Foundation

/// Error types that can occur during Firestore operations
enum FirestoreError: Error {
    case documentNotFound
    case decodingError
    case unknownError(Error)
    
    var localizedDescription: String {
        switch self {
        case .documentNotFound:
            return "The requested document was not found."
        case .decodingError:
            return "Failed to decode the document."
        case .unknownError(let error):
            return "An unexpected error occurred: \(error.localizedDescription)"
        }
    }
}

extension FirestoreError {
    
    static func == (lhs: FirestoreError, rhs: FirestoreError) -> Bool {
        switch (lhs, rhs) {
        case (.documentNotFound, .documentNotFound),
             (.decodingError, .decodingError):
            return true
        case (.unknownError, .unknownError):
            return false // Unknown errors contain different error instances, so they should not be equal
        default:
            return false
        }
    }
}

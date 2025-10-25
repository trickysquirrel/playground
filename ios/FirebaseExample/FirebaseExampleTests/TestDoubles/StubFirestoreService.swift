//
//  Untitled.swift
//  FirebaseExample
//
//  Created by Richard Moult on 21/10/2025.
//

@testable import FirebaseExample

final class StubFirestoreService: FirestoreServiceProtocol {
    var error: FirestoreError?
    var documentResults: [String: Any] = [:]
    var documentStreams: [String: Any] = [:]
    
    func fetchDocument<T: FirestoreDocument>(_ type: T.Type) async throws -> T {
        // If there's a predefined error, throw it
        if let error = error {
            throw error
        }
        
        // Check if we have a specific result for this document type
        let key = "\(T.collectionPath)/\(T.documentId)"
        if let result = documentResults[key] as? Result<T, FirestoreError> {
            return try result.get()
        }
        
        // Otherwise throw a default error
        throw FirestoreError.documentNotFound
    }
    
    private func listenToDocument<T: FirestoreDocument>(_ type: T.Type, includeMetadataChanges: Bool) -> AsyncStream<Result<T, FirestoreError>> {
        let key = "\(T.collectionPath)/\(T.documentId)"
        
        // Return the predefined stream if it exists
        if let stream = documentStreams[key] as? AsyncStream<Result<T, FirestoreError>> {
            return stream
        }
        
        // Otherwise return a default stream with a document not found error
        return AsyncStream { continuation in
            continuation.yield(.failure(.documentNotFound))
            continuation.finish()
        }
    }
}

extension StubFirestoreService {
    
    func listenToDocument<T: FirestoreDocument>(_ type: T.Type) -> AsyncStream<Result<T, FirestoreError>> {
        return listenToDocument(type, includeMetadataChanges: false)
    }
    
    func fetchCacheDocument<T: FirestoreDocument>(_ type: T.Type) async throws -> T {
        try await fetchDocument(type)
    }
    
    func fetchServerDocument<T: FirestoreDocument>(_ type: T.Type) async throws -> T {
        try await fetchDocument(type)
    }
}

extension StubFirestoreService {
    
    // Helper method to set up specific document results
    func setDocumentResult<T: FirestoreDocument>(_ result: Result<T, FirestoreError>, for type: T.Type) {
        let key = "\(T.collectionPath)/\(T.documentId)"
        documentResults[key] = result
    }
    
    // Helper method to set up document streams
    func setDocumentStream<T: FirestoreDocument>(_ values: [Result<T, FirestoreError>], for type: T.Type) {
        let key = "\(T.collectionPath)/\(T.documentId)"
        let stream = AsyncStream<Result<T, FirestoreError>> { continuation in
            Task {
                for value in values {
                    continuation.yield(value)
                    try? await Task.sleep(nanoseconds: 100_000_000) // 0.1 second delay between emissions
                }
                continuation.finish()
            }
        }
        documentStreams[key] = stream
    }
}


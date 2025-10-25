//
//  FirestoreService.swift
//  FirebaseExample
//
//  Created by Richard Moult on 21/10/2025.
//

import Foundation
import FirebaseFirestore

protocol FirestoreServiceProtocol: Sendable {
    @preconcurrency
    func fetchDocument<T: FirestoreDocument & Sendable>(_ type: T.Type) async throws -> T
    @preconcurrency
    func fetchCacheDocument<T: FirestoreDocument & Sendable>(_ type: T.Type) async throws -> T
    @preconcurrency
    func fetchServerDocument<T: FirestoreDocument & Sendable>(_ type: T.Type) async throws -> T
    @preconcurrency
    func listenToDocument<T: FirestoreDocument & Sendable>(_ type: T.Type) async -> AsyncStream<Result<T, FirestoreError>>
}

// A service to fetch Firestore documents
actor FirestoreService: FirestoreServiceProtocol {
    
    private let db = Firestore.firestore()
    
    /// Fetches a document of the specified type and source
    /// - Parameters type: FirestoreDocument type
    /// - Parameters source: Firestore source type, cache / service / default
    /// - Returns: The decoded document
    /// - Throws: FirestoreError if the document cannot be fetched or decoded
    private func fetchDocument<T: FirestoreDocument>(_ type: T.Type, source: FirestoreSource) async throws -> T {
        do {
            let documentReference = db.collection(T.collectionPath).document(T.documentId)
            let documentSnapshot = try await documentReference.getDocument(source: source)
            
            guard documentSnapshot.exists else {
                throw FirestoreError.documentNotFound
            }
            
            guard let document = try? documentSnapshot.data(as: T.self) else {
                throw FirestoreError.decodingError
            }
            
            return document
        } catch let error as FirestoreError {
            throw error
        } catch {
            throw FirestoreError.unknownError(error)
        }
    }

    /// Listens for changes to a document of the specified type
    /// - Parameter type: FirestoreDocument type
    /// - Parameter includeMetadataChanges: Whether to receive metadata-only changes
    /// - Returns: An AsyncStream that emits the document when changes occur or an error when they happen
    private func listenToDocument<T: FirestoreDocument>(_ type: T.Type, includeMetadataChanges: Bool) -> AsyncStream<Result<T, FirestoreError>> {
        AsyncStream { continuation in
            let documentReference = db.collection(T.collectionPath).document(T.documentId)
            
            let listener = documentReference.addSnapshotListener(includeMetadataChanges: includeMetadataChanges) { snapshot, error in
                if let error = error {
                    continuation.yield(.failure(.unknownError(error)))
                    return
                }
                
                guard let snapshot = snapshot else {
                    continuation.yield(.failure(.documentNotFound))
                    return
                }
                
                if !snapshot.exists {
                    continuation.yield(.failure(.documentNotFound))
                    return
                }
                
                do {
                    let document = try snapshot.data(as: T.self)
                    continuation.yield(.success(document))
                } catch {
                    continuation.yield(.failure(.decodingError))
                }
            }
            
            continuation.onTermination = { _ in
                listener.remove()
            }
        }
    }
}

extension FirestoreService {
    
    nonisolated func listenToDocument<T: FirestoreDocument & Sendable>(_ type: T.Type) async -> AsyncStream<Result<T, FirestoreError>> {
        await self.listenToDocument(type, includeMetadataChanges: false)
    }
    
    nonisolated func fetchDocument<T: FirestoreDocument & Sendable>(_ type: T.Type) async throws -> T {
        try await self.fetchDocument(type, source: .default)
    }
    
    nonisolated func fetchCacheDocument<T: FirestoreDocument & Sendable>(_ type: T.Type) async throws -> T {
        try await self.fetchDocument(type, source: .cache)
    }
    
    nonisolated func fetchServerDocument<T: FirestoreDocument & Sendable>(_ type: T.Type) async throws -> T {
        try await self.fetchDocument(type, source: .server)
    }
}

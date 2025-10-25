//
//  FirestoreService+Helper.swift
//  FirebaseExample
//
//  Created by Richard Moult on 21/10/2025.
//

@testable import FirebaseExample

extension FirestoreService {
    
    static func stub() -> StubFirestoreService { StubFirestoreService() }
    
    static func stub(error: FirestoreError) -> StubFirestoreService {
        let mockService = Self.stub()
        mockService.error = error
        return mockService
    }
    
    static func stubAnyKnownError() -> StubFirestoreService {
        Self.stub(error: .decodingError)
    }
    
    static func stubAnyUnKnownError() -> StubFirestoreService {
        Self.stub(error: .unknownError(DummyError()))
    }
    
    static func stubDocument<T: FirestoreDocument>(_ document: T) -> StubFirestoreService {
        let mockService = FirestoreService.stub()
        mockService.setDocumentResult(.success(document), for: T.self)
        return mockService
    }
    
    static func stubListeningDocument<T: FirestoreDocument>(_ values: [Result<T, FirestoreError>]) -> StubFirestoreService {
        let mockService = FirestoreService.stub()
        mockService.setDocumentStream(values, for: T.self)
        return mockService
    }
}

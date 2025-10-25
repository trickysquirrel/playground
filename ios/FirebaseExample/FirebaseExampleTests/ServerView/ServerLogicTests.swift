//
//  ServerLogic.swift
//  FirebaseExample
//
//  Created by Richard Moult on 21/10/2025.
//

import Testing
import Dependencies
@testable import FirebaseExample

extension MaintenanceModeServerLogic {
    
    static func sut(fs: FirestoreServiceProtocol) -> MaintenanceModeServerLogic {
        withDependencies {
            $0.firestoreService = fs
        } operation: {
            MaintenanceModeServerLogic()
        }
    }
}

@Suite struct MaintenanceModeServerLogicTests {
    
    @Test("Successfully receives document")
    @MainActor
    func test_success() async throws {
        // Arrange
        let mockDocument = MaintenanceModeDocument.fake()
        let mockService = FirestoreService.stubDocument(mockDocument)
        let logic = MaintenanceModeServerLogic.sut(fs: mockService)
        
        // Fetch
        let result = try await logic.fetch()
        
        // Check
        #expect(result.active == true)
        #expect(result.title == "title")
        #expect(result.description == "desc")
    }
    
    @Test("Fails to parse document correctly")
    @MainActor
    func test_decoding_error() async throws {
        // Arrange
        let mockService = FirestoreService.stub(error: FirestoreError.decodingError)
        let logic = MaintenanceModeServerLogic.sut(fs: mockService)
        
        // Fetch
        let error = await #expect(throws: FirestoreError.self) {
            try await logic.fetch()
        }
        
        // Check
        #expect(error! == FirestoreError.decodingError)
    }
}

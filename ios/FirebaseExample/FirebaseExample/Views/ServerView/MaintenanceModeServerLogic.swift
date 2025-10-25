//
//  MaintenanceModeLogic.swift
//  FirebaseExample
//
//  Created by Codex on 21/10/2025.
//

import Foundation
import Dependencies

// Logic restricted to fetching from the server source only
protocol MaintenanceModeFetchLogicI {
    func fetch() async throws -> MaintenanceModeDocument
}

struct MaintenanceModeServerLogic: MaintenanceModeFetchLogicI {
    @Dependency(\.firestoreService) var firestoreService

    func fetch() async throws -> MaintenanceModeDocument {
        try await firestoreService.fetchServerDocument(MaintenanceModeDocument.self)
    }
}


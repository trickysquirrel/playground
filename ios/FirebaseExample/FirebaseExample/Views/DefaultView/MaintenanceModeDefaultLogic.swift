//
//  MaintenanceModeDefaultLogic.swift
//  FirebaseExample
//
//  Created by Richard Moult on 22/10/2025.
//

import Foundation
import Dependencies


struct MaintenanceModeDefaultLogic: MaintenanceModeFetchLogicI {
    @Dependency(\.firestoreService) var firestoreService

    func fetch() async throws -> MaintenanceModeDocument {
        try await firestoreService.fetchDocument(MaintenanceModeDocument.self)
    }
}

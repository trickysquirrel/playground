//
//  MaintenanceModeCacheLogic.swift
//  FirebaseExample
//
//  Created by Richard Moult on 22/10/2025.
//

import Foundation
import Dependencies

protocol AnnouncementsDocumentFetchLogicI {
    func fetch() async throws -> AnnouncementsDocument
}

struct AnnouncementsCacheLogic: AnnouncementsDocumentFetchLogicI {
    @Dependency(\.firestoreService) var firestoreService

    func fetch() async throws -> AnnouncementsDocument {
        try await firestoreService.fetchCacheDocument(AnnouncementsDocument.self)
    }
}

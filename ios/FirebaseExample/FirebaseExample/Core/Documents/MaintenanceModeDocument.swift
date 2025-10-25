//
//  MaintenanceModeDocument.swift
//  FirebaseExample
//
//  Created by Codex on 21/10/2025.
//

import Foundation

// Firestore document representing maintenance mode settings
struct MaintenanceModeDocument: FirestoreDocument {
    // Use the known document id for Identifiable conformance
    var id: String { Self.documentId }

    let active: Bool
    let title: String
    let description: String

    // Map JSON keys explicitly for clarity
    enum CodingKeys: String, CodingKey {
        case active = "active"
        case title = "title"
        case description = "description"
    }

    // Firestore location
    static var collectionPath: String { "testAppResources" }
    static var documentId: String { "maintenanceMode" }
}


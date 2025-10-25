//
//  AnnouncementsDocument.swift
//  FirebaseExample
//
//  Created by Codex on 22/10/2025.
//

import Foundation

// Firestore document representing a list of announcements
struct AnnouncementsDocument: FirestoreDocument {
    // Use the known document id for Identifiable conformance
    var id: String { Self.documentId }

    let announcements: [Announcement]

    // Map JSON keys explicitly for clarity
    enum CodingKeys: String, CodingKey {
        case announcements = "announcements"
    }

    // Firestore location
    static var collectionPath: String { "testAppResources" }
    static var documentId: String { "announcements" }

    // Nested announcement item
    struct Announcement: Codable {
        let title: String

        enum CodingKeys: String, CodingKey {
            case title = "title"
        }
    }
}


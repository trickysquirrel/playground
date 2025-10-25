//
//  NewsDocument.swift
//  FirebaseExample
//
//  Created by Codex on 22/10/2025.
//

import Foundation

// Firestore document representing a list of news items
struct NewsDocument: FirestoreDocument {
    // Use the known document id for Identifiable conformance
    var id: String { Self.documentId }

    let items: [Item]

    // Map JSON keys explicitly for clarity
    enum CodingKeys: String, CodingKey {
        case items = "items"
    }

    // Firestore location
    static var collectionPath: String { "testAppResources" }
    static var documentId: String { "news" }

    // Nested news item
    struct Item: Codable {
        let title: String
        let description: String
        let imageUrl: String

        enum CodingKeys: String, CodingKey {
            case title = "title"
            case description = "description"
            case imageUrl = "imageUrl"
        }
    }
}

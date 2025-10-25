//
//  FirestoreDocument.swift
//  FirebaseExample
//
//  Created by Richard Moult on 21/10/2025.
//

protocol FirestoreDocument: Codable, Identifiable {
    static var collectionPath: String { get }
    static var documentId: String { get }
}

//
//  NewsListenLogic.swift
//  FirebaseExample
//
//  Created by Richard Moult on 22/10/2025.
//

import Dependencies

protocol NewsListenLogicI {
    func listenToChanges() async -> AsyncStream<Result<NewsDocument, FirestoreError>>
}

struct NewsListenLogic: NewsListenLogicI {
    @Dependency(\.firestoreService) var firestoreService

    func listenToChanges() async -> AsyncStream<Result<NewsDocument, FirestoreError>> {
        await firestoreService.listenToDocument(NewsDocument.self)
    }
}

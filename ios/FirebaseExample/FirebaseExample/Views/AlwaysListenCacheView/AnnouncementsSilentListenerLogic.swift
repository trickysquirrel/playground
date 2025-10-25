//
//  AnnouncementsSilentListenerLogic.swift
//  FirebaseExample
//
//  Created by Richard Moult on 22/10/2025.
//

import Dependencies

class AnnouncementsSilentListenerLogic {

    @Dependency(\.firestoreService) var firestoreService
    
    private var streamTask: Task<Void, Never>?

    deinit {
        streamTask?.cancel()
    }
        
    func silentListener() {
        streamTask?.cancel()
        streamTask = Task { [weak self] in
            guard let self = self else { return }
            let stream = await firestoreService.listenToDocument(AnnouncementsDocument.self)
            for await _ in stream {
                if Task.isCancelled { break }
            }
        }
    }
}

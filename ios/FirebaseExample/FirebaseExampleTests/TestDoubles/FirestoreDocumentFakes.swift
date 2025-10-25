//
//  MaintenanceModeDocumentFake.swift
//  FirebaseExample
//
//  Created by Richard Moult on 21/10/2025.
//

@testable import FirebaseExample

extension MaintenanceModeDocument {
    static func fake() -> MaintenanceModeDocument {
        MaintenanceModeDocument(active: true, title: "title", description: "desc")
    }
}

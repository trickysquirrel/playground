//
//  FirebaseDependancies.swift
//  StudentApp
//
//  Created by Richard Moult on 7/3/2025.
//

import Foundation
import Dependencies

/*

 Example
 struct ExampleViewModel: View {
     @Dependency(\.firestoreService) var firestoreService
 }
*/

private enum FirestoreServiceKey: DependencyKey {
    static let liveValue: FirestoreServiceProtocol = FirestoreService()
}

extension DependencyValues {
    var firestoreService: FirestoreServiceProtocol {
        get { self[FirestoreServiceKey.self] }
        set { self[FirestoreServiceKey.self] = newValue }
    }
}

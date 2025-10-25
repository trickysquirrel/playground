//
//  ErrorLogDependancy.swift
//  StudentApp
//
//  Created by Richard Moult on 13/3/2025.
//

import Dependencies

/*
 Example
 struct ExampleViewModel: View {
     @Dependency(\.errorLog) var errorLog
 }
*/

private enum ErrorLogKey: DependencyKey {
    static let liveValue: ErrorLogI = ErrorLog()
}

extension DependencyValues {
    var errorLog: ErrorLogI {
        get { self[ErrorLogKey.self] }
        set { self[ErrorLogKey.self] = newValue }
    }
}

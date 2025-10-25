//
//  ErrorLog.swift
//  FirebaseExample
//
//  Created by Richard Moult on 21/10/2025.
//

import FirebaseCrashlytics

protocol ErrorLogI {
    func send(_ error: Error)
}

/// Sending logs to approriate error logger
struct ErrorLog: ErrorLogI {
    func send(_ error: Error) {
        Crashlytics.crashlytics().record(error: error)
    }
}

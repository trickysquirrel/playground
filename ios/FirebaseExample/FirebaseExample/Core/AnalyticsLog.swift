//
//  AnalyticsLog.swift
//  FirebaseExample
//
//  Created by Richard Moult on 21/10/2025.
//

import FirebaseAnalytics

protocol AnalyticsLogProtocol {
    func send(key: String, parameters: [String: Any])
}

/// Sending logs to approriate error logger
struct AnalyticsLog: AnalyticsLogProtocol {
    func send(key: String, parameters: [String: Any]) {
        Analytics.logEvent(key, parameters: parameters)
    }
}

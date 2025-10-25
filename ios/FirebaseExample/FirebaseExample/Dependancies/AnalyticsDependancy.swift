//
//  AnalyticsDependancy.swift
//  FirebaseExample
//
//  Created by Richard Moult on 21/10/2025.
//

import Dependencies

/*
 Example
 struct ExampleViewModel: View {
     @Dependency(\.analyticsLog) var analyticsLog
 }
*/

private enum AnalyticsLogKey: DependencyKey {
    static let liveValue: AnalyticsLogProtocol = AnalyticsLog()
}

extension DependencyValues {
    var analyticsLog: AnalyticsLogProtocol {
        get { self[AnalyticsLogKey.self] }
        set { self[AnalyticsLogKey.self] = newValue }
    }
}

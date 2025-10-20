//
//  MessageOverlayView.swift
//  FirebaseTemplate
//
//  Created by Richard Moult on 19/10/2025.
//

import SwiftUI

@MainActor
struct MessageOverlayView: View {
    
    @Environment(\.scenePhase) private var scenePhase
    @State private var isExpired = false
    @State private var taskID = UUID()
    
    var body: some View {
        Group {
            if isExpired {
                EmptyView()
            } else {
                Text("Message overlay view")
            }
        }
        .task(id: taskID) {
            // Start a 10-second countdown once the view appears or when `taskID` changes
            // If the task is cancelled (view disappears or taskID changes), we simply stop without changing state
            try? await Task.sleep(for: .seconds(3))
            // Only flip the flag if the task wasn't cancelled
            if !Task.isCancelled {
                isExpired = true
            }
        }
        .onChange(of: scenePhase) { oldPhase, newPhase in
            if newPhase == .active {
                // Reset state and restart the countdown by changing taskID
                isExpired = false
                taskID = UUID()
            }
        }
    }
}

//
//  InfoView.swift
//  TabExample
//
//  Created by Richard Moult on 20/10/2025.
//

import SwiftUI

struct InfoSheetView: View {
    
    @Bindable var router: ScheduleRouter

    var body: some View {
        VStack(spacing: 16) {
            Text("Info")
                .font(.title2)
            Text("This is an informational sheet")
                .foregroundStyle(.secondary)
            Button("Dismiss") {
                router.dismissSheet()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

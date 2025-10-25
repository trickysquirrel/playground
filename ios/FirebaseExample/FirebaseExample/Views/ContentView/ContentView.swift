//
//  ContentView.swift
//  FirebaseExample
//
//  Created by Richard Moult on 21/10/2025.
//

import SwiftUI

struct DetailView: View {
    let title: String

    var body: some View {
        Text("Empty view for \(title)")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemBackground))
            .navigationTitle(title)
    }
}

struct ContentView: View {
    
    private let silentAnncouncementListener = AnnouncementsSilentListenerLogic()
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(spacing: 16) {
                    NavigationLink(destination: maintananceServerView()) {
                        CardView(title: "Server", description: "Only load information from the server source on appear")
                    }
                    .tint(Color.primary)
                    NavigationLink(destination: maintananceDefaultView()) {
                        CardView(title: "Default", description: "Use the default source on appear")
                    }
                    .tint(Color.primary)
                    NavigationLink(destination: newsListenView()) {
                        CardView(title: "Listen", description: "Always listen for changes")
                    }
                    .tint(Color.primary)
                    NavigationLink(destination: announcementCacheView()) {
                        CardView(title: "Always listen, load from cache", description: "App constantly listens out for changes but on appear gets data from cache")
                    }
                    .tint(Color.primary)
                }
                .padding(.horizontal)
            }
            .padding()
            .onAppear {
                // code should really exist in app init, but adding here so its easier to find for demo code
                silentAnnouncementListener()
            }
        }
    }
    
    private func maintananceServerView() -> MaintenanceModeView {
        let logic = MaintenanceModeServerLogic()
        let vm = MaintenanceModeViewModel(logic: logic)
        return MaintenanceModeView(viewModel: vm, headingText: "This view only shows data from the server not the cache, once shown will not change")
    }

    private func maintananceDefaultView() -> MaintenanceModeView {
        let logic = MaintenanceModeDefaultLogic()
        let vm = MaintenanceModeViewModel(logic: logic)
        return MaintenanceModeView(viewModel: vm, headingText: "This view only shows data using default fetch logic, once shown will not change.  Given the network is off this view will show last loaded data.")
    }
    
    private func newsListenView() -> NewsListenView {
        let logic = NewsListenLogic()
        let vm = NewsViewModel(logic: logic)
        return NewsListenView(viewModel: vm)
    }

    private func announcementCacheView() -> AnnouncementsCacheView {
        let logic = AnnouncementsCacheLogic()
        let vm = AnnouncementsViewModel(logic: logic)
        return AnnouncementsCacheView(viewModel: vm)
    }
    
    private func silentAnnouncementListener() {
        silentAnncouncementListener.silentListener()
    }

}

#Preview {
    ContentView()
}


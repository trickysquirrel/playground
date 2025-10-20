//
//  ContentView.swift
//  FirebaseTemplate
//
//  Created by Richard Moult on 19/10/2025.
//

import SwiftUI

struct RootTabView: View {
    
    @State private var appRouter = AppRouter()
    @State private var searchText = ""

    var body: some View {
        TabView(selection: $appRouter.selectedTab) {
           
            ScheduleRootView(router: appRouter.scheduleRouter)
                .tabItem { Label("Schedule", systemImage: "calendar") }
                .tag(AppTab.schedule.rawValue)

            MapRootView(router: appRouter.mapRouter)
                .tabItem { Label("Map", systemImage: "map") }
                .tag(AppTab.map.rawValue)

            NewsRootView(router: appRouter.newsRouter)
                .tabItem { Label("News", systemImage: "newspaper") }
                .tag(AppTab.news.rawValue)

            SearchRootView(router: appRouter.searchRouter)
                .tabItem { Label("Search", systemImage: "magnifyingglass") }
                .tag(AppTab.search.rawValue)

         }
         .tabBarMinimizeBehavior(.onScrollDown)
         .tabViewBottomAccessory(content: MessageOverlayView.init)
    }
}

#Preview {
    RootTabView()
}


//
//  ScheduleRootView.swift
//  FirebaseTemplate
//
//  Created by Richard Moult on 20/10/2025.
//

import SwiftUI

struct ScheduleRootView: View {
    @Bindable var router: ScheduleRouter

    var body: some View {
        NavigationStack(path: $router.navigationPath) {
            ScheduleView(router: router)
                .navigationDestination(for: ScheduleRouter.Route.self) { route in
                    switch route {
                    case .detail:
                        ScheduleDetailsView(router: router)
                    case .profile:
                        ProfileView()
                    }
                }
                .sheet(item: $router.presentedSheet) { sheet in
                    switch sheet {
                    case .info:
                        InfoSheetView(router: router)
                    }
                }
                .fullScreenCover(item: $router.presentedFullScreenCover) { sheet in
                    switch sheet {
                    case .info:
                        InfoSheetView(router: router)
                    }
                }
        }
    }
}

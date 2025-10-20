//
//  Router.swift
//  Firebase-Template
//
//  Created by Richard Moult on 18/10/2025.
//

import Foundation
import SwiftUI

enum AppTab: Int {
    case schedule = 0
    case map
    case news
    case search
}

@Observable
class AppRouter {
    
    // provides a router for each tab item
    var scheduleRouter = ScheduleRouter()
    var mapRouter = EmptyRouter()
    var newsRouter = EmptyRouter()
    var searchRouter = EmptyRouter()
    
    // keeps track of selected tab
    var selectedTab = AppTab.search.rawValue

    func navigateTo(tab: AppTab) {
        selectedTab = tab.rawValue
    }
}

//
//  ScheduleRouter.swift
//  TabExample
//
//  Created by Richard Moult on 20/10/2025.
//

import Foundation
import SwiftUI

@Observable
class ScheduleRouter {
    
    var navigationPath = NavigationPath()
    var presentedSheet: Sheet? = nil
    var presentedFullScreenCover: Sheet? = nil
    
    enum Route: Hashable {
        case detail
        case profile
    }
    
    enum Sheet: Identifiable, Hashable {
        case info
        var id: String {
            switch self {
            case .info: return "info"
            }
        }
    }
    
    func navigateTo(route: Route) {
        navigationPath.append(route)
    }
    
    func present(sheet: Sheet) {
        presentedSheet = sheet
    }
    
    func presentFullScreenCover(sheet: Sheet) {
        presentedFullScreenCover = sheet
    }
    
    func dismissSheet() {
        if presentedSheet != nil {
            presentedSheet = nil
        } else if presentedFullScreenCover != nil {
            presentedFullScreenCover = nil
        }
    }
}

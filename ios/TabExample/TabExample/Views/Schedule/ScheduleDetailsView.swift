//
//  ScheduleDetailsView.swift
//  TabExample
//
//  Created by Richard Moult on 20/10/2025.
//

import SwiftUI

struct ScheduleDetailsView: View {
    
    @Bindable var router: ScheduleRouter
    
    var body: some View {
        Button {
            router.navigateTo(route: .detail)
        } label: {
            Text("details view")
        }
    }
}

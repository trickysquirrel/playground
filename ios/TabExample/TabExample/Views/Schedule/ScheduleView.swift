//
//  ScheduleView.swift
//  FirebaseTemplate
//
//  Created by Richard Moult on 19/10/2025.
//

import SwiftUI

struct ScheduleItem: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let time: String
    let notes: String?
}

struct ScheduleSection: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let items: [ScheduleItem]
}

// Sample data for now; replace with your real source later
private let sections: [ScheduleSection] = [
    .init(title: "Morning", items: [
        .init(title: "Standup", time: "09:30", notes: "Daily team sync"),
        .init(title: "Design Review", time: "11:00", notes: nil)
    ]),
    .init(title: "Afternoon", items: [
        .init(title: "Lunch", time: "12:30", notes: "With Alex"),
        .init(title: "Client Call", time: "15:00", notes: "Project Alpha status")
    ]),
    .init(title: "Evening", items: [
        .init(title: "Client Call", time: "16:00", notes: "Project Alpha status"),
        .init(title: "Client Call", time: "17:00", notes: "Project Alpha status"),
        .init(title: "Client Call", time: "18:00", notes: "Project Alpha status"),
        .init(title: "Wrap Up", time: "18:30", notes: "Plan for tomorrow")
    ])
]

struct ScheduleView: View {
    
    @Bindable var router: ScheduleRouter
    
    fileprivate func sectionItem(_ item: ScheduleItem) -> some View {
        return HStack(alignment: .firstTextBaseline, spacing: 12) {
            Text(item.time)
                .font(.system(.title3, design: .rounded))
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)
                .frame(width: 64, alignment: .leading)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.headline)
                if let notes = item.notes, !notes.isEmpty {
                    Text(notes)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding(.vertical, 6)
    }
    
    var body: some View {
        List {
            ForEach(sections) { section in
                Section(header: Text(section.title)) {
                    ForEach(section.items) { item in
                        sectionItem(item)
                        .onTapGesture {
                            router.navigateTo(route: .detail)
                        }
                    }
                }
            }
        }
        .navigationTitle("Schedule")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("New", systemImage: "person.crop.circle") {
                    router.navigateTo(route: .profile)
                }
            }
            ToolbarItem(placement: .topBarLeading) {
                Button("Info", systemImage: "info.circle") {
                    router.present(sheet: .info)
                }
            }
            ToolbarItem(placement: .topBarLeading) {
                Button("Block", systemImage: "pencil.circle") {
                    router.presentFullScreenCover(sheet: .info)
                }
            }
            ToolbarItem(placement: .topBarLeading) {
                Button("Block", systemImage: "map") {
                    router.navigateToTab?(.map)
                }
            }
        }
    }
}

#Preview {
    ScheduleView(router: ScheduleRouter())
}


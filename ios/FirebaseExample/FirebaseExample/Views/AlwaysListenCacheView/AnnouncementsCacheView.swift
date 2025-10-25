//
//  AnnouncementsCacheView.swift
//  FirebaseExample
//
//  Created by Codex on 22/10/2025.
//

import SwiftUI

struct AnnouncementsCacheView: View {

    private struct Constants {
        static let heading: String = "This view only shows data from the cache but listens whilst the app is open"
        static let errorTitle: String = "Sorry something went wrong"
    }

    @State private var viewModel: AnnouncementsViewModelI

    init(viewModel: AnnouncementsViewModelI) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        VStack(spacing: 16) {
            switch viewModel.state {
            case .loading:
                FullLoadingView()
            case .error(let error):
                TryAgainView(
                    title: Constants.errorTitle,
                    description: error.localizedDescription,
                    action: { viewModel.loadDocument() }
                )
            case .loaded(let viewData):
                successView(viewData: viewData)
            }
        }
        .padding()
        .onAppear { viewModel.loadDocument() }
        .navigationTitle("Announcements")
    }

    private func successView(viewData: AnnouncementsViewData) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(Constants.heading)
                    .font(.headline)
                    .foregroundStyle(.secondary)

                ForEach(viewData.items, id: \.self) { title in
                    Text(title)
                }
            }
            .padding(.horizontal)
        }
    }
}

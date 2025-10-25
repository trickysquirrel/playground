//
//  MaintenanceModeView.swift
//  FirebaseExample
//
//  Created by Codex on 21/10/2025.
//

import SwiftUI

struct MaintenanceModeView: View {

    private struct Constants {
        static let screenTitle: String = "View"
        static let cardCornerRadius: CGFloat = 12
        static let cardPadding: CGFloat = 16
        static let vSpacing: CGFloat = 8
        static let hPadding: CGFloat = 16
        static let statusPrefix: String = "Active: "
    }

    @State private var viewModel: MaintenanceModeViewModelI
    private let headingText: String

    init(viewModel: MaintenanceModeViewModelI, headingText: String) {
        _viewModel = State(wrappedValue: viewModel)
        self.headingText = headingText
    }

    var body: some View {
        VStack(spacing: Constants.vSpacing) {
            switch viewModel.state {
            case .loading:
                FullLoadingView()

            case .error:
                TryAgainView(
                    title: "Sorry something went wrong",
                    description: "Please try again",
                    action: { viewModel.loadDocument() }
                )

            case .loaded(let viewData):
                successView(viewData: viewData)
            }
        }
        .padding(.horizontal, Constants.hPadding)
        .navigationTitle(Constants.screenTitle)
        .onAppear { viewModel.loadDocument() }
    }

    private func successView(viewData: MaintenanceModeViewData) -> some View {
        VStack(alignment: .leading, spacing: Constants.vSpacing) {
            Text(headingText)
                .font(.headline)
                .foregroundColor(.secondary)

            VStack(alignment: .leading, spacing: Constants.vSpacing) {
                Text(viewData.title)
                    .font(.title3)
                    .fontWeight(.semibold)

                Text(viewData.description)
                    .font(.body)
                    .foregroundColor(.primary)

                HStack(spacing: 6) {
                    Circle()
                        .fill(viewData.active ? Color.green : Color.red)
                        .frame(width: 10, height: 10)
                    Text(Constants.statusPrefix + (viewData.active ? "true" : "false"))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            .padding(Constants.cardPadding)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: Constants.cardCornerRadius)
                    .fill(Color(.secondarySystemBackground))
            )
        }
    }
}


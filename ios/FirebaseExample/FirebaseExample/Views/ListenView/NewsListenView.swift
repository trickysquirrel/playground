
//
//  NewsListenView.swift
//  FirebaseExample
//
//  Created by Codex on 25/10/2025.
//

import SwiftUI

struct NewsListenView: View {

    private struct Constants {
        static let heading: String = "Will update info live as firestore change"
        static let errorTitle: String = "Sorry something went wrong"
        static let vSpacing: CGFloat = 16
        static let cardCornerRadius: CGFloat = 12
        static let cardPadding: CGFloat = 12
        static let imageSize: CGSize = CGSize(width: 300, height: 200)
    }

    @State private var viewModel: NewsViewModelI

    init(viewModel: NewsViewModelI) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        VStack(spacing: Constants.vSpacing) {
            switch viewModel.state {
            case .loading:
                FullLoadingView()

            case .error(let error):
                TryAgainView(
                    title: Constants.errorTitle,
                    description: error.localizedDescription,
                    action: { viewModel.listen() }
                )

            case .loaded(let viewData):
                successView(viewData: viewData)
            }
        }
        .padding()
        .onAppear { viewModel.listen() }
        .onDisappear { viewModel.stopListening() }
        .navigationTitle("News")
    }

    private func successView(viewData: NewsViewData) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Constants.vSpacing) {
                Text(Constants.heading)
                    .font(.headline)
                    .foregroundStyle(.secondary)

                VStack(spacing: Constants.vSpacing) {
                    ForEach(viewData.items) { item in
                        itemCard(item)
                    }
                }
            }
            .padding(.horizontal)
        }
    }

    private func itemCard(_ item: NewsItemViewData) -> some View {
        VStack(alignment: .center, spacing: 12) {
            WebImageView(
                imageUrl: item.imageUrl,
                width: Constants.imageSize.width,
                height: Constants.imageSize.height
            )
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))

            VStack(alignment: .leading, spacing: 6) {
                Text(item.title)
                    .font(.headline)
                    .foregroundStyle(.primary)
                Text(item.description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            Spacer(minLength: 0)
        }
        .padding(Constants.cardPadding)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: Constants.cardCornerRadius, style: .continuous)
                .fill(Color(.secondarySystemBackground))
        )
    }
}

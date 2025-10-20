//
//  NewsView.swift
//  FirebaseTemplate
//
//  Created by Richard Moult on 19/10/2025.
//

import SwiftUI

struct NewsPost: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let subtitle: String
    let author: String
    let timeAgo: String
    let tag: String
    let imageName: String
}

private extension NewsPost {
    static let sample: [NewsPost] = [
        .init(title: "SwiftUI Gets a Fresh Look",
              subtitle: "Discover the latest design patterns and transitions for iOS.",
              author: "Jane Doe",
              timeAgo: "2h",
              tag: "SwiftUI",
              imageName: "sun.max.fill"),
        .init(title: "MapKit Tips & Tricks",
              subtitle: "Make your maps pop with annotations and custom styles.",
              author: "Chris P.",
              timeAgo: "5h",
              tag: "MapKit",
              imageName: "map.fill"),
        .init(title: "Async/Await Deep Dive",
              subtitle: "Concurrency made friendly with real-world examples.",
              author: "Sam Lee",
              timeAgo: "1d",
              tag: "Swift",
              imageName: "bolt.fill"),
        .init(title: "Designing for Vision",
              subtitle: "Create immersive layouts that feel at home everywhere.",
              author: "Alex M.",
              timeAgo: "2d",
              tag: "Design",
              imageName: "sparkles")
    ]
}

struct NewsView: View {

    private let posts = NewsPost.sample

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                header
                    .padding(.horizontal)
                
                LazyVStack(spacing: 16, pinnedViews: []) {
                    ForEach(posts) { post in
                        NewsCard(post: post)
                            .padding(.horizontal)
                    }
                }
            }
            .padding(.vertical)
        }
        .background(gradientBackground)
        .navigationTitle("News")
    }

    private var gradientBackground: some View {
        LinearGradient(colors: [Color(.systemBackground), Color(.secondarySystemBackground)], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }

    private var header: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 6) {
                Text("Curated stories for you")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Image(systemName: "newspaper.fill")
                .font(.system(size: 28))
                .symbolRenderingMode(.hierarchical)
                .foregroundStyle(.blue)
                .padding(10)
                .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
        }
        .padding(.top, 4)
    }
}

private struct NewsCard: View {
    let post: NewsPost

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 10) {
                Image(systemName: post.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 44, height: 44)
                    .symbolRenderingMode(.multicolor)
                    .padding(10)
                    .background(
                        Circle().fill(LinearGradient(colors: [.blue.opacity(0.2), .purple.opacity(0.2)], startPoint: .topLeading, endPoint: .bottomTrailing))
                    )

                VStack(alignment: .leading, spacing: 4) {
                    Text(post.title)
                        .font(.headline)
                        .lineLimit(2)
                    Text(post.subtitle)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                }
                Spacer()
            }

            HStack(spacing: 8) {
                Label(post.tag, systemImage: "tag.fill")
                    .font(.caption)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 10)
                    .background(
                        Capsule(style: .continuous)
                            .fill(.ultraThinMaterial)
                    )

                Text("•")
                    .foregroundStyle(.secondary)

                Text("By \(post.author)")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Spacer()

                Image(systemName: "clock.fill")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(post.timeAgo)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(.background)
                .shadow(color: .black.opacity(0.06), radius: 10, x: 0, y: 6)
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .strokeBorder(.quaternary, lineWidth: 0.5)
                )
        )
    }
}

#Preview {
    NewsView()
}

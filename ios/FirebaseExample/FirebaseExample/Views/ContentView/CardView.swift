//
//  CardView.swift
//  FirebaseExample
//
//  Created by Richard Moult on 21/10/2025.
//

import SwiftUI

struct CardView: View {
    let title: String
    let description: String

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(.primary)
                Text(description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.leading)
            }
            Spacer(minLength: 8)
            Image(systemName: "chevron.right")
                .font(.body.weight(.semibold))
                .foregroundStyle(.tertiary)
                .accessibilityHidden(true)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2)
        )
    }
}

#Preview("long text", traits: .sizeThatFitsLayout) {
    CardView(title: "this is a title", description: "this is a longer description blah blah etc etc and some extra stuff here")
}

#Preview("short text", traits: .sizeThatFitsLayout) {
    CardView(title: "title", description: "description")
}

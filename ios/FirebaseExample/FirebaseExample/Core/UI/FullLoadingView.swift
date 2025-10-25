//
//  FullLoadingView.swift
//  FirebaseExample
//
//  Created by Richard Moult on 21/10/2025.
//

import SwiftUI

/*
 Use FullLoadingView to display a full screen animation to the use whilst
 the user is waiting for something to load
 example:
    FullLoadingView()
*/

struct FullLoadingView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 16) {
                Text("loading")
                ProgressView()
                    .progressViewStyle(.circular)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
        }
    }
}

//
//  NewsRootView.swift
//  FirebaseTemplate
//
//  Created by Richard Moult on 20/10/2025.
//

import SwiftUI

struct NewsRootView: View {
    @Bindable var router: EmptyRouter

    var body: some View {
        NavigationStack(path: $router.navigationPath) {
            NewsView()
        }
    }
}

//
//  NewsListenPreview.swift
//  FirebaseExample
//
//  Created by Richard Moult on 25/10/2025.
//

import SwiftUI

#if DEBUG

@Observable
private final class ViewModelLoading: NewsViewModelI {
    var state: NewsViewModel.ViewState = .loading
    func listen() {}
    func stopListening() {}
}

@Observable
private final class ViewModelFailure: NewsViewModelI {
    var state: NewsViewModel.ViewState = .error(FirestoreError.decodingError)
    func listen() {}
    func stopListening() {}
}

@Observable
private final class ViewModelLoaded: NewsViewModelI {
    var state: NewsViewModel.ViewState = .loaded(NewsViewData(from: NewsDocument(items: [.init(title: "t", description: "d", imageUrl: "https://picsum.photos/300/200")])))
    func listen() {}
    func stopListening() {}
}

#Preview("success") {
    let vm = ViewModelLoaded()
    NewsListenView(viewModel: vm)
}

#Preview("loading") {
    let vm = ViewModelLoading()
    NewsListenView(viewModel: vm)
}

#Preview("failure") {
    let vm = ViewModelFailure()
    NewsListenView(viewModel: vm)
}

#endif

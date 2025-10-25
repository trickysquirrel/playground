//
//  AnnouncementsCachePreviews.swift
//  FirebaseExample
//
//  Created by Richard Moult on 22/10/2025.
//

import SwiftUI

#if DEBUG

@Observable
private final class ViewModelLoading: AnnouncementsViewModelI {
    var state: AnnouncementsViewModel.ViewState = .loading
    func loadDocument() {}
}

@Observable
private final class ViewModelFailure: AnnouncementsViewModelI {
    var state: AnnouncementsViewModel.ViewState = .error(NSError(domain: "domain", code: 1))
    func loadDocument() {}
}

@Observable
private final class ViewModelLoaded: AnnouncementsViewModelI {
    var state: AnnouncementsViewModel.ViewState = .loaded(AnnouncementsViewData(from: AnnouncementsDocument(announcements: [AnnouncementsDocument.Announcement(title: "a1")])))
    func loadDocument() {}
}

#Preview("success") {
    let vm = ViewModelLoaded()
    AnnouncementsCacheView(viewModel: vm)
}

#Preview("loading") {
    let vm = ViewModelLoading()
    AnnouncementsCacheView(viewModel: vm)
}

#Preview("failure") {
    let vm = ViewModelFailure()
    AnnouncementsCacheView(viewModel: vm)
}

#endif

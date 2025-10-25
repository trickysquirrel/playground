//
//  MaintenancePreviews.swift
//  FirebaseExample
//
//  Created by Richard Moult on 22/10/2025.
//

import SwiftUI

#if DEBUG

@Observable
private final class ViewModelLoading: MaintenanceModeViewModelI {    
    var state: MaintenanceModeViewModel.ViewState = .loading
    func loadDocument() {}
}

@Observable
private final class ViewModelFailure: MaintenanceModeViewModelI {
    var state: MaintenanceModeViewModel.ViewState = .error(NSError(domain: "domain", code: 1))
    func loadDocument() {}
}

@Observable
private final class ViewModelLoaded: MaintenanceModeViewModelI {
    var state: MaintenanceModeViewModel.ViewState = .loaded(MaintenanceModeViewData(from: MaintenanceModeDocument(active: true, title: "title", description: "description")))
    func loadDocument() {}
}

#Preview("success") {
    let vm = ViewModelLoaded()
    MaintenanceModeView(viewModel: vm, headingText: "heading")
}

#Preview("loading") {
    let vm = ViewModelLoading()
    MaintenanceModeView(viewModel: vm, headingText: "heading")
}

#Preview("failure") {
    let vm = ViewModelFailure()
    MaintenanceModeView(viewModel: vm, headingText: "heading")
}

#endif

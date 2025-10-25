//
//  MaintenanceModeViewModel.swift
//  FirebaseExample
//
//  Created by Codex on 21/10/2025.
//

import Foundation
import Observation
import Dependencies

// MARK: - ViewData
struct MaintenanceModeViewData: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let active: Bool

    init(from document: MaintenanceModeDocument) {
        self.title = document.title
        self.description = document.description
        self.active = document.active
    }
}

protocol MaintenanceModeViewModelI {
    var state: MaintenanceModeViewModel.ViewState { get }
    func loadDocument()
}

// MARK: - ViewModel
@MainActor @Observable
final class MaintenanceModeViewModel: MaintenanceModeViewModelI {

    @ObservationIgnored
    @Dependency(\.errorLog) private var errorLog
    
    enum ViewState {
        case loading
        case error(Error)
        case loaded(MaintenanceModeViewData)
    }

    private(set) var state: ViewState = .loading
    private let logic: MaintenanceModeFetchLogicI

    init(logic: MaintenanceModeFetchLogicI) {
        self.logic = logic
    }

    func loadDocument() {
        state = .loading
        Task {
            do {
                let document = try await logic.fetch()
                let viewData = MaintenanceModeViewData(from: document)
                state = .loaded(viewData)
            } catch {
                state = .error(error)
                errorLog.send(error)
            }
        }
    }
}


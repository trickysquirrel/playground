//
//  AnnouncementsViewModel.swift
//  FirebaseExample
//
//  Created by Codex on 22/10/2025.
//

import Foundation
import Observation
import Dependencies

// MARK: - ViewData
struct AnnouncementsViewData: Identifiable {
    let id = UUID()
    let items: [String]

    init(from document: AnnouncementsDocument) {
        self.items = document.announcements.map { $0.title }
    }
}

protocol AnnouncementsViewModelI {
    var state: AnnouncementsViewModel.ViewState { get }
    func loadDocument()
}

// MARK: - ViewModel
@MainActor @Observable
final class AnnouncementsViewModel: AnnouncementsViewModelI {

    @ObservationIgnored
    @Dependency(\.errorLog) private var errorLog

    enum ViewState {
        case loading
        case error(Error)
        case loaded(AnnouncementsViewData)
    }

    private(set) var state: ViewState = .loading

    private let logic: AnnouncementsDocumentFetchLogicI

    init(logic: AnnouncementsDocumentFetchLogicI) {
        self.logic = logic
    }

    func loadDocument() {
        state = .loading
        Task {
            do {
                let document = try await logic.fetch()
                let viewData = AnnouncementsViewData(from: document)
                state = .loaded(viewData)
            } catch {
                state = .error(error)
                errorLog.send(error)
            }
        }
    }
}


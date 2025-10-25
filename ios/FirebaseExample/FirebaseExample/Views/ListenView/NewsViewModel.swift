//
//  NewsViewModel.swift
//  FirebaseExample
//
//  Created by Codex on 22/10/2025.
//

import Foundation
import Observation
import Dependencies

// MARK: - ViewData
struct NewsItemViewData: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let imageUrl: String

    init(from item: NewsDocument.Item) {
        self.title = item.title
        self.description = item.description
        self.imageUrl = item.imageUrl
    }
}

struct NewsViewData: Identifiable {
    let id = UUID()
    let items: [NewsItemViewData]

    init(from document: NewsDocument) {
        self.items = document.items.map { NewsItemViewData(from: $0) }
    }
}

// MARK: - ViewModel
protocol NewsViewModelI {
    var state: NewsViewModel.ViewState { get }
    func listen()
    func stopListening()
}

import Combine

@MainActor @Observable
final class NewsViewModel: NewsViewModelI {
    
    @ObservationIgnored @Dependency(\.errorLog) private var errorLog
    
    enum ViewState {
        case loading
        case error(FirestoreError)
        case loaded(NewsViewData)
    }

    var state: ViewState = .loading
    private let logic: NewsListenLogicI
    @ObservationIgnored private(set) var streamTask: Task<Void, Never>?

    init(logic: NewsListenLogicI) {
        self.logic = logic
    }
    
    deinit {
        streamTask?.cancel()
    }
    
    func stopListening() {
        streamTask?.cancel()
    }

    func listen() {
        Task {
            streamTask?.cancel()
            streamTask = Task { [weak self] in
                guard let self = self else { return }
                let stream = await self.logic.listenToChanges()
                for await result in stream {
                    if Task.isCancelled { break }
                    switch result {
                    case .success(let document):
                        let viewData = NewsViewData(from: document)
                        self.state = .loaded(viewData)
                    case .failure(let error):
                        self.errorLog.send(error)
                        self.state = .error(error)
                    }
                }
            }
        }
    }
}

//
//  NewsViewModelTests.swift
//  FirebaseExample
//
//  Created by Richard Moult on 22/10/2025.
//

import Testing
import Dependencies
import XCTest
import Observation
import Combine
@testable import FirebaseExample

extension NewsViewModel {
    
    static func sut(fs: FirestoreServiceProtocol, errLog: ErrorLogI) -> NewsViewModel {
        withDependencies {
            $0.firestoreService = fs
            $0.errorLog = errLog
        } operation: {
            let logic = NewsListenLogic()
            return NewsViewModel(logic: logic)
        }
    }
}

extension NewsDocument {
    static func fake() -> NewsDocument {
        NewsDocument(items: [
            NewsDocument.Item(title: "title1", description: "desc1", imageUrl: "https://link1.com"),
            NewsDocument.Item(title: "title2", description: "desc2", imageUrl: "https://link2.com")
        ])
    }
}


@Suite struct NewsViewModelTests {
    
    @Test("sets loading state start on init")
    @MainActor
    func test_init_state_is_loading() async throws {
        // Given
        let stubErrorLog = ErrorLog.stub()
        let stubService = FirestoreService.stub()
        // When
        let viewModel = NewsViewModel.sut(fs: stubService, errLog: stubErrorLog)
        // Then
        #expect({
            if case .loading = viewModel.state { return true }
            Issue.record("Expected .loading, got \(String(describing: viewModel.state))")
            return false
        }())
    }

    
    @Test("Test the logic correctly handles loading, and a subsequent error.")
    @MainActor
    func test_logic_returning_document_then_error() async {
        // Given
        let stubErrorLog = ErrorLog.stub()
        let fakeDocument = NewsDocument.fake()
        let stubService = FirestoreService.stub()

        // When
        let viewModel = NewsViewModel.sut(fs: stubService, errLog: stubErrorLog)
        var observer = observeChanges(of: viewModel, \.state).makeAsyncIterator()
        viewModel.listen()
        stubService.setDocumentStream([.success(fakeDocument), .failure(FirestoreError.documentNotFound)], for: NewsDocument.self)

        // Then
        let first = await observer.next()
        #expect({
            if case .loaded = first { return true }
            Issue.record("Expected .loaded, got \(String(describing: first))")
            return false
        }())

        let second = await observer.next()
        #expect({
            if case .error(.documentNotFound) = second { return true }
            Issue.record("Expected .error(.documentNotFound), got \(String(describing: second))")
            return false
        }())
    }
    
}

@MainActor func observeChanges<Object: AnyObject, Value>(
    of object: Object,
    _ keyPath: KeyPath<Object, Value>
) -> AsyncStream<Value> {
    AsyncStream { continuation in
        @MainActor func track() {
            withObservationTracking {
                _ = object[keyPath: keyPath]   // establish dependency
            } onChange: {
                Task { @MainActor in
                    continuation.yield(object[keyPath: keyPath])
                    track() // re-arm to observe the next change
                }
            }
        }
        track()
    }
}

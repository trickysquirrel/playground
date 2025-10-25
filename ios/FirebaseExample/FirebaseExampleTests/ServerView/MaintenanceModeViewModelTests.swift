//
//  MaintenanceModeViewModelTests.swift
//  FirebaseExample
//
//  Created by Richard Moult on 21/10/2025.
//

import Testing
import Dependencies
@testable import FirebaseExample

extension MaintenanceModeViewModel {
    
    static func sut(fs: FirestoreServiceProtocol, errLog: ErrorLogI) -> MaintenanceModeViewModel {
        withDependencies {
            $0.firestoreService = fs
            $0.errorLog = errLog
        } operation: {
            let logic = MaintenanceModeServerLogic()
            return MaintenanceModeViewModel(logic: logic)
        }
    }
}

@Suite struct MaintenanceModeViewModelTests {
    
    @Test("Successfully sets loading start on init")
    @MainActor
    func test_state_set_up_is_loading() async throws {
        // Arrange
        let stubErrorLog = ErrorLog.stub()
        let fakeDocument = MaintenanceModeDocument.fake()
        let stubService = FirestoreService.stubDocument(fakeDocument)
        let viewModel = MaintenanceModeViewModel.sut(fs: stubService, errLog: stubErrorLog)
        
        // Check
        if case .loading = viewModel.state {} else {
            Issue.record("Unexpected result: \(viewModel.state)")
        }
    }
    
    @Test("State changes to error on logic error (polling)")
    @MainActor
    func test_success_set_state_error() async throws {
        let stubErrorLog = ErrorLog.stub()
        let fakeDocument = MaintenanceModeDocument.fake()
        let stubService = FirestoreService.stubDocument(fakeDocument)
        let viewModel = MaintenanceModeViewModel.sut(fs: stubService, errLog: stubErrorLog)

        viewModel.loadDocument()

        let ok = await waitForState(viewModel, until: {
            if case .loaded(let viewData) = $0 {
                #expect(viewData.active == true)
                #expect(viewData.title == "title")
                #expect(viewData.description == "desc")
                return true
            }
            else { return false }
        })

        if !ok {
            Issue.record("Timed out waiting for .error state, got: \(viewModel.state)")
        }
    }
    
    @Test("State changes to error on logic error (polling)")
    @MainActor
    func test_failure_set_state_error_and_logs_polling() async throws {
        var errorLogCalled = false
        let stubErrorLog = ErrorLog.stub { errorLogCalled = true }
        let mockService = FirestoreService.stub(error: FirestoreError.decodingError)
        let viewModel = MaintenanceModeViewModel.sut(fs: mockService, errLog: stubErrorLog)

        viewModel.loadDocument()

        let ok = await waitForState(viewModel, until: {
            if case .error = $0 { return true } else { return false }
        })
        
        #expect(errorLogCalled)

        if !ok {
            Issue.record("Timed out waiting for .error state, got: \(viewModel.state)")
        }
    }
    
    
}

extension MaintenanceModeViewModelTests {
    
    @MainActor
    func waitForState(
        _ viewModel: MaintenanceModeViewModel,
        until predicate: @escaping (MaintenanceModeViewModel.ViewState) -> Bool,
        timeout: Duration = .seconds(2),
        poll: Duration = .milliseconds(20)
    ) async -> Bool {
        let start = ContinuousClock.now
        while ContinuousClock.now - start < timeout {
            if predicate(viewModel.state) { return true }
            try? await Task.sleep(for: poll)
        }
        return false
    }

}

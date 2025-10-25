//
//  Untitled.swift
//  FirebaseExample
//
//  Created by Richard Moult on 21/10/2025.
//

@testable import FirebaseExample

struct StubErrorLog: ErrorLogI {
    var sendCalled: (() -> Void)?
    func send(_ error: Error) {
        sendCalled?()
    }
}

extension ErrorLog {
    static func stub(_ sendCalled: (() -> Void)? = nil) -> StubErrorLog {
        StubErrorLog(sendCalled: sendCalled)
    }
}

//
//  FirebaseExampleApp.swift
//  FirebaseExample
//
//  Created by Richard Moult on 21/10/2025.
//

import SwiftUI
import Firebase

@main
struct AppLauncher {
    // If not running unit test then launch the app, else launch placeholder view
    // This will stop firebase from initiating or any code firing that could interact with the
    // object in the unit tests
    static func main() throws {
        if NSClassFromString("XCTestCase") == nil {
            FirebaseExampleApp.main()
        } else {
            TestApp.main()
        }
    }
}

// Only viewed during unit tests
struct TestApp: App {
    var body: some Scene { WindowGroup { Text("Running Unit Tests") } }
}

struct FirebaseExampleApp: App {
    
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

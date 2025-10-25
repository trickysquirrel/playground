//
//  PrincipleClass\.swift
//  FirebaseExample
//
//  Created by Richard Moult on 21/10/2025.
//

// Must be referenced in the test target info.plist

import XCTest
import FirebaseCore
import FirebaseFirestore

class PrincipleClass: NSObject {
    
    override init() {
        super.init()
        configureFirebase()
        clearFirebase()
        NSTimeZone.default = NSTimeZone(name: "Australia/Melbourne")! as TimeZone
    }

    func configureFirebase() {
        FirebaseApp.configure()
        let settings = Firestore.firestore().settings
        settings.cacheSettings = MemoryCacheSettings.init()
        Firestore.firestore().settings = settings
    }

    /**
     * Cleans up the current FIRApp, freeing associated data and returning its name to the pool for
     * future use. This method is thread safe.
     */
    func deleteApp() {
        // Create an expectation
        let expectation = XCTestExpectation(description: "Firebase app deletion")
        
        // Delete the Firebase app
        FirebaseApp.app()?.delete { success in
            print("FirebaseApp.app().delete success \(success)")
            // Fulfill the expectation when the deletion completes
            expectation.fulfill()
        }
        
        // Wait for the expectation to be fulfilled with a timeout
        // Adjust the timeout value as needed based on expected deletion time
        XCTWaiter().wait(for: [expectation], timeout: 5.0)
    }

    /**
     * Clears the persistent storage. This includes pending writes and cached documents.
     *
     * Must be called while the firestore instance is not started (after the app is shutdown or when
     * the app is first initialized). On startup, this method must be called before other methods
     * (other than `FIRFirestore.settings`). If the firestore instance is still running, the function
     * will complete with an error code of `FailedPrecondition`.
     *
     * Note: `clearPersistence(completion:)` is primarily intended to help write reliable tests that
     * use Firestore. It uses the most efficient mechanism possible for dropping existing data but
     * does not attempt to securely overwrite or otherwise make cached data unrecoverable. For
     * applications that are sensitive to the disclosure of cache data in between user sessions we
     * strongly recommend not to enable persistence in the first place.
     */
    func clearFirebase() {
        Firestore.firestore().clearPersistence { error in
            if let error = error {
               print(">>>> ERROR TESTSETUP could not clear cache \(error)")
            }
        }
    }
}

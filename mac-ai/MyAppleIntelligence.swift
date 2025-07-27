
// Link via MacOS shortcuts to power up AI capabilities
// Read https://medium.com/@richardmoult75/macos-26-tahoe-apple-intelligence-repeated-responses-e0099995f3eb


import ArgumentParser
import Foundation
import FoundationModels

@main
struct MyAppleIntelligence: AsyncParsableCommand {
    
    @Option(name: .short, help: "system prompt")
    var s: String

    @Option(name: .short, help: "user prompt")
    var u: String

    @Option(name: .short, help: "temperature 0-1")
    var t: Double

    func run() async throws {
        let session = LanguageModelSession(instructions: s)
        do {
            let response: LanguageModelSession.Response<String>
            let options = GenerationOptions(temperature: t)
            response = try await session.respond(to: u, options: options)
            print(response.content)
        } catch {
            print(error)
        }
    }
}

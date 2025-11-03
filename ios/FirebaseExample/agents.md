This Agents.md file provides comprehensive guidance for OpenAI Codex and other AI agents working with this codebase.

- Act as an expert swift developer aiding an senior developer.  
- Think through the problems step by step. 
- Please think about the questions thoroughly and in great detail. 
- Consider multiple approaches and look to create the simplest code possible.
- Try different methods if your first approach doesn't work.
- If you’re unsure about any aspect of the request or if the request lacks necessary information, say “I don’t have enough information to confidently assess this.” and ask the appropriate questions to fill to gaps in unknowlege.
- Only provide code to answer the question
- Seperate out code into appropriate code blocks.
- Seperate code blocks for struct data models, view models and views.
- Write code using MVVM style

## Project Structure for OpenAI Codex Navigation

- `/FirebaseExample`: Source code that OpenAI Codex should analyze/create
  - `/Core`: Basic reusable components for any feature to use
    - `/Documents`: FirestoreDocuments to be used throughout the app
  - `/Dependancies`: Hold all dependancies that need to be reference throughout the code base
  - `/Views`: Each View/feature is help in sub folder, each view holds the ViewModel / ViewData / View
- `/FirebaseExampleTests`: Test files that OpenAI Codex should maintain and extend

## Coding Conventions for OpenAI Codex

### MVVM Architecture

MVVM (Model-View-ViewModel) is an architectural coding pattern for structuring SwiftUI views. The goal of the pattern is to separate the view definition from the business logic behind it. Your views will not depend on any specific model type if done correctly.

View: This is the view definition. In SwiftUI, this would be your declarative view definition.
ViewModel: The view directly binds to properties on the view model to send and receive updates. Since the view model has no reference to the view, it becomes reusable for use with multiple views.
Model: A model refers to a domain model. For example, a ContactView would have a ContactViewModel that acts as a communication layer with a Contact domain model.

The View only communicates with the ViewModel
The View does not know anything about the (domain) model behind the ViewModel
The ViewModel has no reference to the View and becomes reusable to be used with any View


### General Conventions for Agents.md Implementation

- Must use SwiftUI
- Prefer to use await async AsyncStream
- Do not use the Combine framework
- Make the code as simple as possible to read and understand

### Naming

- View objects must end in View
- ViewModel objects must end in ViewModel
- ViewModels return data as ViewData structs


### Constants

When we have values that are repeating in the same file, it would be better to have a Constants declaration so when we change we only change once and not make a mistake of forgetting the other places.
```
class SomeView {
    private struct Constants {
      static let keyUsedMultipleTimes: String = "some_key_used_multiple_times"
      static let valueUsedMultipleTimes: CGFloat = 10
    }   
}
```

### Guards

Prefer at top of function
guard let self = self else { return }

If the completion block is a one liner you can miss out the guard
button.onSelect { [weak self] in self?.doSomething() }

A completion block with more than one line we prefer a guard
```
button.onSelect { [weak self] in
   guard let self = self else { return }
   self.doSomething()
   self.doAnotherThing()
}
```

### If Statements

Prefer bob == false over !bob where possible

### State

Prefer `let` over `var` (even for structs as it shows our intent that these are never mutated)
Prefer `private`, 'private(set)' where possible.
When adding state to a class look for ways to make state as simple as possible. 


## Images

The app includes the package SDWebImage.  Prefer to use the app wrapper view WebImageView, see example below

```
    WebImageView(imageUrl: "https://someimageurl", width: 100, height: 100)
```

## Creating firestore documents

A FirestoreDocument represents the document structure as well as its collectionPath and documentId
 
In the case of doucment that has
 
collectionPath = "collectionNameExample"
documentId = "documentNameExample"
with the following data structure
 
```
{
    "active": true,
    "title": "the is a title string",
    "description": "this is a description string"
}
```
 
The FirestoreDocument should be

``` 
struct ExampleDocument: FirestoreDocument {
     
    var id: String { Self.documentId }
    let active: Bool
    let title: String
    let description: String
    
    // add all keys except id as that is not in the doc and needs to be auto generated
    enum CodingKeys: String, CodingKey {
        case active = "active"
        case title = "title"
        case description = "description"
    }

    static var collectionPath: String { "collectionNameExample" }
    static var documentId: String { "documentNameExample" }
}
```

# Fetch Document Example

The example below provides an example of a simple feature using MVVM
It includes an example of fetching a Document
It includes a Logic object to download or access the information required for a feature
It includes a ViewModel that downloads the document and transforms it into a ViewData object so the view logic can be as simple as possible

### Logic
```
protocol ExampleLogicI {
    func fetch() async throws -> ExampleDocument
}

// Object to download documents using default source
struct ExampleDefaultLogic: ExampleLogicI {
    
    @Dependency(\.firestoreService) var firestoreService
    
    func fetch() async throws -> ExampleDocument {
        return try await firestoreService.fetchDocument(ExampleDocument.self)
    }
}

// Object to only download documents from the server
struct ExampleServerLogic: ExampleLogicI {
    
    @Dependency(\.firestoreService) var firestoreService
    
    func fetch() async throws -> ExampleDocument {
        return try await firestoreService.fetchServerDocument(ExampleDocument.self)
    }
}

// Object to only retrieve the documents from the existing cache
struct ExampleCacheOnlyLogic: ExampleLogicI {
    
    @Dependency(\.firestoreService) var firestoreService
    
    func fetch() async throws -> ExampleDocument {
        return try await firestoreService.fetchCacheDocument(ExampleDocument.self)
    }
}

### ViewModel

struct ExampleViewData: Identifiable {
    let id = UUID()
    let items: [String]
    
    init(from document: ExampleDocument) {
        self.items = document.items.map { $0 }
    }
}

protocol ExampleViewModelI {
    func loadDocument()
}

@MainActor @Observable
final class ExampleViewModel {

    @ObservationIgnored
    @Dependency(\.errorLog) var errorLog

    enum ViewState {
        case loading
        case error(Error)
        case loaded(ExampleViewData)
    }
    
    var state: ViewState = .loading
    private let logic = ExampleDefaultLogic()
    
    init() {
        loadDocument()
    }
    
    func loadDocument() {
        state = .loading
        Task {
            do {
                let document = try await logic.fetch()
                let viewData = ExampleViewData(from: document)
                state = .loaded(viewData)
            } catch {
                errorLog.send(error)
                state = .error(error)
            }
        }
    }
}
```


## Listen Example

The example below provides an example of a simple feature using MVVM
It includes an example of listening to a Document, effectiviley streaming information
It includes a Logic object to download or access the information required for a feature
It includes a ViewModel that downloads the document and transforms it into a ViewData object so the view logic can be as simple as possible

### Logic

```
protocol ExampleLogicI {
    func listenToChanges() async -> AsyncStream<Result<ExampleDocument, FirestoreError>>
}

struct ExampleLogic: ExampleLogicI {

    @Dependency(\.firestoreService) var firestoreService
        
    func listenToChanges() async -> AsyncStream<Result<ExampleDocument, FirestoreError>> {
        return await firestoreService.listenToDocument(ExampleDocument.self)
    }
}
```

### ViewModel

```
@MainActor @Observable
final class ListenExampleViewModel {

    @ObservationIgnored
    @Dependency(\.errorLog) var errorLog

    enum ViewState {
        case loading
        case error(Error)
        case loaded(ExampleViewData)
    }
    
    private(set) var state: ViewState = .loading
    private let logic: ListenExampleDocumentLogicI
    @ObservationIgnored private(set) var streamTask: Task<Void, Never>?
    
    init(logic: ListenExampleDocumentLogicI) {
        self.logic = logic
    }
    
    deinit {
        streamTask?.cancel()
    }
    
    func stopListening() {
        streamTask?.cancel()
    }

    func listen() {
        state = .loading
        streamTask?.cancel()
        streamTask = Task { [weak self] in
            guard let self = self else { return }
            let stream = await self.logic.listenToChanges()
            for await result in stream {
                if Task.isCancelled { break }
                switch result {
                case .success(let logicData):
                    let viewData = ExampleViewData(from: logicData)
                    self.state = .loaded(viewData)
                case .failure(let error):
                    errorLog.send(error)
                    self.state = .error(error)
                }
            }
        }
    }
}
```

## View Example

```
struct ExampleView: View {
    @State private var viewModel = ExampleViewModel()
    
    var body: some View {
        VStack {
            switch viewModel.state {
            case .loading:
                FullLoadingView()
            case .error:
                TryAgainView(message: "Sorry", description: "more info", action: {
                    // reload data here
                })
            case .loaded(let viewData):
                successView(viewData: viewData)
            }
        }
        .navigationTitle("Example title")
    }
    
    private func successView(viewData: ExampleViewData) -> some View {
        // return view to display view data
    }
}
```
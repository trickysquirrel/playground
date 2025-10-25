# ServerView feature

## Firestore Document

Create a FirestoreDocument, using @FirestoreDocument file, called MaintenanceModeDocument using the following information.  If already exists do not create a new one.
 
collectionPath = "testAppResources"
documentId = "maintenanceMode"
with the following data structure
 
```
{
    "active": true,
    "title": "the is a title string",
    "description": "this is a description string"
}
```

## Logic

Only user server source

## ViewModel

Only download the document once on view appear.
Whilst downloading set the state to loading
If download successful transform the document to a ViewModel and set state to loaded
If download failure set state to error with Firestore error

## View

On appear request to download document
When state is loading show FullLoadingView
When state is error show TryAgainView and reload document on selection
When state is loaded show...
- A heading "This view only shows data from the server not the cache"
- Show the ViewModel data in a card UI with title, description and if active or not.

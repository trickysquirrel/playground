# AnnouncementView feature

## Firestore Document

Create a FirestoreDocument, using @FirestoreDocument file, called AnnouncementsDocument using the following information.  If already exists do not create a new one.
 
collectionPath = "testAppResources"
documentId = "announcements"
with the following data structure
 
```
{
    "announcements": [
        {
            "title": "example title 1"
        },
        {
            "title": "example title 2"
        }
    ]
}
```

## Logic

Only user cache source

## ViewModel

Only download the document once on view appear.
Whilst downloading set the state to loading
If download successful transform the document to a ViewData and set state to loaded
If download failure set state to error with Firestore error

## View

On appear request to download document
When state is loading show FullLoadingView
When state is error show TryAgainView and reload document on selection
When state is loaded show...
- A heading "This view only shows data from the cache but listens whilst the app is open"
- Show the ViewModel data in a card UI with title


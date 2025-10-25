# News View feature

## Firestore Document

Create a FirestoreDocument, using @FirestoreDocument file, called NewsDocument using the following information.  If already exists do not create a new one.
 
collectionPath = "testAppResources"
documentId = "news"
with the following data structure
 
```
{
    "items": [
        {
            "title": "example title 1",
            "description": "example description 1",
            "imageUrl": "exampleImageUrl1"
        },
        {
            "title": "example title 2"
            "description": "example description 2",
            "imageUrl": "exampleImageUrl2"
        }
    ]
}
```

## Logic

Constantly listen out for changes

## ViewModel

Always listen out for changes
Whilst downloading for the first time set the state to loading
If download successful transform the document to a ViewData and set state to loaded
If download failure set state to error with Firestore error
Each time the document changes update the ViewData

## View

On appear request to download document
When state is loading show FullLoadingView
When state is error show TryAgainView and reload document on selection
When state is loaded show...
- A heading "Will update info live as firestore change"
- Show the ViewModel data in a card UI with title



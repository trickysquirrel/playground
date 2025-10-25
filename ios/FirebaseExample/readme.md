# Firebase document example + AI

This project provides an example of how to use AI with firebase.

Provided Document Load Template

## Server View

Show how to download a firestore document only from the server.

- Always gets doc from server on view appear
- Data does not update live whilst on the view
- If network disabled the view will error

## Default View

Shows how to download a firestore document using the default mechanism

- Get the doc using the default mechanism, which is to try the server first then try the cache
- Data does not update live whilst on the view
- If network disabled the view will show the last successful download
- If not downloaded the data before and no network, then error view is seen

## Always listen cache view

Shows how always load the views data from the cache, but when it appears its always the latest data

- On view appear get the latest doc from the cache - super quick, unlikely to see the loading view
- Data does not update live whilst on the view 
- App continually listens out for changes.

## Listen view

Show how to stream the view data from firestore live to the view

- On view appear get the current doc version and continually listens out for changes
- If you change the cloud firestore doc, the view updates live


# How to use AI

As of writing this OpenAI Codex out performs Xcode considerably.

Take note of the agents.md file in the route, Codex picks this up by default.
In the Agent folder you'll see multiple md files for different data types used in the app.

When creating something like the AnnouncementFeature, which is fairly simple, you can one-shot the models and view, but I find it best to do one thing at a time.  So you can prompt like this...

```
read Agent/AnnouncementFeature.md and create the firestore document
```

check the output, then

```
read Agent/AnnouncementFeature.md and create the logic object in the Views/AlwaysListenCacheView folder
```

check code, writing some test

```
read Agent/AnnouncementFeature.md and create the view in the Views/AlwaysListenCacheView folder
```

check code, writing some previews

# Trax
A Sample Project to demo the fetch of data from API Source

## This is a simple app that only fetch the information from the API and display the list and the details using collectionView

## Architecture Used
MVC + [Coordinator Pattern](http://khanlou.com/2015/10/coordinators-redux/) + Programmatic UI

#### The Choice of using Coordinator is actually based on my experience on how to architecture the app with minimal used of boilerplate and to solve the navigation flow of the app for the developer to be clear on what will be the next screen to show. 

### The Main app is actually dissected with these parts
- Coordinator
	- The flow navigation of the app
- VC
	- logic controller of the app
- View
	- The class of the app on where the UI is being designed programmatically

## Pods Used

[SnapKit](https://github.com/SnapKit/SnapKit)
- DSL for Programmatic UI

[King Fisher](https://github.com/onevcat/Kingfisher)
- Swift library for downloading and caching images from the web.

[Moya](https://github.com/Moya/Moya)
- Networking abstraction layer that sufficiently encapsulates actually calling Alamofire directly. It should be simple enough that common things are easy, but comprehensive enough that complicated things are also easy.

[RealmSwift](https://realm.io/docs/swift/latest/)
- Data Persistence(local storage)

### How To Install

1. Cocoapods needs to be install first on your machine

2. Clone the project

3. run in the terminal
	
	``` 
	pod install 
	``` 

4. go inside the directory and 
	``` 
	open Trax.xcworkspace.xcworkspace
	```

5. Build and Run

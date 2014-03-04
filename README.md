##Requirements

####Implement the simple RSS Reader for iPhone with a following requirements:
* The main application's screen should be a table filled with a news sorted by date. Table cell should contain title, short description and an image for one news piece;
* On cell selection the screen with a full information should be opened; it should contain the "Open in browser" button with the same action executed on tap.
* Please use the http://feeds.bbci.co.uk/news/rss.xml feed
* Use as less 3rd party libraries as possible. 

####Additional score points will be given for:
* An ability for application to work offline - showing the news received last time;
* Text search among the news list;
* Core Data using for news cache;
* Checking for internet/server reachability and notifying user about it;
* An ability to set feed URL endpoint in the Settings app;

Please consider to write correct and "good" code if cannot managed to write a "working" one. It means that the application structure and architecture should be clean and clear, following OOP principles, design patterns and best practices. It would be great if you can also put together a read me to go with your code. 

##Initial Thoughts
* I'm going to focus on a iPhone-only version. If I have time, I'll make the app Universal
* I'm going to use standard iOS controls. I'm not planning to apply a layout/design now. That includes icons, launch images, custom fonts and assets.
* This scenario looks like the ideal opportunity to use NSFetchedResultsController
* I'm going to use Storyboards and Segues
* 3rd party libraries I'm going to use: *AFNetworking* (I'm a contributor, yay!) and *CWStatusBarNotification*. I normally use a dependency manager system (CocoaPods) to add 3rd party libraries to my projects, but in this case, for the sake of simplicity, I'm going to add the libs manually to the project.
* The offline/cache related tasks will be done using Core Data. The table view will always read from a Core Data database, and when the feed gets refreshed, the table view will be notified, so it can be reloaded
* For text search, I'm going to use NSFetchRequest with NSPredicates
* The URL endpoint will be stored in NSUserDefaults and it can be changed in a Settings screen
* This is a living document and can be changed along the way :)

##After 5h30min+ of development

* All the 4 requirements should be OK. The lack of layout burn my eyes, but at least it's working :)
* All the 5 additional score points should also be OK.
* I had to rush a little bit to deliver everythin, so I didn't have the time I'd like to test the features. I now the app has one annoying bug that sometimes shows the first cell duplicated. But it is certainly an easy fix.
* I didn't have time to do the iPad version.

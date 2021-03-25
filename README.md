# ghs-app
The GHS App was developed for Glendora High School by [ssmytech](https://ssmytech.com)

Development began in Winter 2018 and is still being maintained today.

A public repo was created on 04/24/2021, purging all visible API keys/secrets.

## Summary
The GHS App was created to help students, parents, and teachers on a daily basis. Access to resources such as Aeries, schedules, maps, and events provides a quick, easy, and reliable way to stay updated. 
The GHS App is one of the best ways for students and parents to become more familiar with teachers, staff, and the campus itself. 

## Inside the app
The app is primarily Swift3/4 with some Objective-C to bridge headers for external APIs. GET requests pull data from Google Calendars and Google Sheets and this JSON is parsed/allocated into TableViews.

Other APIs include Lottie, Firebase, Alamofire, and TwitterCore. 

These dependencies are managed by CocoaPods.

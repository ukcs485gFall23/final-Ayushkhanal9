[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/Zeg3sUAD)
[![Open in Codespaces](https://classroom.github.com/assets/launch-codespace-7f7980b617ed060a017424585567c406b6ee15c891e84e1186181d67ecf80aa0.svg)](https://classroom.github.com/open-in-codespaces?assignment_repo_id=12394477)
# CareKitSample+ParseCareKit
![Swift](https://img.shields.io/badge/swift-5.7-brightgreen.svg) ![Xcode 14.0+](https://img.shields.io/badge/xcode-14.0%2B-blue.svg) ![iOS 16.0+](https://img.shields.io/badge/iOS-16.0%2B-blue.svg) ![watchOS 9.0+](https://img.shields.io/badge/watchOS-9.0%2B-blue.svg) ![CareKit 3.0+](https://img.shields.io/badge/CareKit-3.0%2B-red.svg) ![ci](https://github.com/netreconlab/CareKitSample-ParseCareKit/workflows/ci/badge.svg?branch=main)

# Introduction
I've developed a unique self-help application named 'Self Help Buddy,' aimed at providing comprehensive support and resources for personal development and mental well-being. Unlike traditional self-help apps that may focus on a single aspect of well-being, EmpowerYou offers a diverse range of tools and content to address various areas of a user's life.

Self Help Buddy's core features include mood tracking, stress management techniques, guided meditation, and educational resources covering topics from emotional intelligence to effective communication skills. One of the standout aspects of this app is its personalized approach. Users can set their goals, whether it's improving self-esteem, managing anxiety, or developing better relationships, and the app tailors its content and recommendations accordingly.

Furthermore, Self Help buddy recognizes the importance of holistic well-being. It integrates physical health tips and routines, understanding that physical health significantly impacts mental health. It also offers a community feature, where users can share their journeys and support each other, fostering a sense of connection and mutual growth.

# Demo Video





# Designed for Users
Self Help Buddy' is an innovative self-help application designed to provide comprehensive support and guidance for individuals seeking personal growth and mental well-being. This app stands out in the crowded field of self-help tools by offering a wide range of features tailored to meet the diverse needs of its users.

The app includes mood tracking, stress management techniques, and guided meditation sessions, catering to those who are looking to improve their mental health and emotional resilience. Additionally, it offers educational resources on topics like emotional intelligence, time management, and inter personal communication, making it an invaluable tool for personal development.

'Self Help Buddy' is unique in its approach to personalization. Users can set specific goals, such as boosting self-confidence, managing anxiety, or building stronger relationships. The app then customizes its content and suggestions to align with these individual objectives, providing a more targeted and effective self-help experience.

<img src="https://user-images.githubusercontent.com/8621344/101721031-06869500-3a75-11eb-9631-88927e9c8f00.png" width="300"> <img src="https://user-images.githubusercontent.com/8621344/101721111-33d34300-3a75-11eb-885e-4a6fc96dbd35.png" width="300"> <img src="https://user-images.githubusercontent.com/8621344/101721146-48afd680-3a75-11eb-955a-7848146a9d6f.png" width="300"><img src="https://user-images.githubusercontent.com/8621344/101721182-5cf3d380-3a75-11eb-99c9-bde40477acf3.png" width="300">

**Similar to the [What's New in CareKit](https://developer.apple.com/videos/play/wwdc2020/10151/) WWDC20 video, this app syncs between data between iOS and an Apple Watch (setting the flag `isSyncingWithRemote` in `Constants.swift` to  `isSyncingWithRemote = false`. Different from the video, setting `isSyncingWithRemote = true` (default behavior) in the aforementioned file syncs iOS and watchOS to a Parse Server.**

ParseCareKit synchronizes the following entities to Parse tables/classes using [Parse-Swift](https://github.com/netreconlab/Parse-Swift):

- [Yes] OCKTask <-> Task
- [Yes] OCKHealthKitTask <-> HealthKitTask 
- [Yes] OCKOutcome <-> Outcome
- [Yes] OCKPatient <-> Patient
- [Yes] OCKCarePlan <-> CarePlan
- [Yes] OCKContact <-> Contact






**Use at your own risk. There is no promise that this is HIPAA compliant and we are not responsible for any mishandling of your data**

# Developed By
- Corey Baker
- Ayush Khanal

# Check List
[ X] Signup/Login screen tailored to app
[ X] Signup/Login with email address
[ X] Custom app logo
[ X] Custom styling
[ X] Add at least 5 new OCKTask/OCKHealthKitTasks to your app
[ ] Have a minimum of 7 OCKTask/OCKHealthKitTasks in your app
[ ] 3/7 of OCKTasks should have different OCKSchedules than what's in the original app
[ X] Use at least 5/7 card below in your app
[ X] InstructionsTaskView - typically used with a OCKTask
 SimpleTaskView - typically used with a OCKTask
[ ] Checklist - typically used with a OCKTask
[X ] Button Log - typically used with a OCKTask
 GridTaskView - typically used with a OCKTask
[ X] NumericProgressTaskView (SwiftUI) - typically used with a OCKHealthKitTask
[ ] LabeledValueTaskView (SwiftUI) - typically used with a OCKHealthKitTask
[ X] Add the LinkView (SwiftUI) card to your app
[ X] Replace the current TipView with a class with CustomFeaturedContentView that subclasses OCKFeaturedContentView. This card should have an initializer which takes any link
[ ] Tailor the ResearchKit Onboarding to reflect your application
[ ] Add tailored check-in ResearchKit survey to your app
[ ] Add a new tab called "Insights" to MainTabView
[X] Replace current ContactView with Searchable contact view
[ ] Change the ProfileView to use a Form view
[ ] Add at least two OCKCarePlan's and tie them to their respective OCKTask's and OCContact's

#


## Setup Your Parse Server

### Heroku
The easiest way to setup your server is using the [one-button-click](https://github.com/netreconlab/parse-hipaa#heroku) deployment method for [parse-hipaa](https://github.com/netreconlab/parse-hipaa).

### Docker
You can setup your [parse-hipaa](https://github.com/netreconlab/parse-hipaa) using Docker. Simply type the following to get parse-hipaa running with postgres locally:

1. Fork [parse-hipaa](https://github.com/netreconlab/parse-hipaa)
2. `cd parse-hipaa`
3.  `docker-compose up` - this will take a couple of minutes to setup as it needs to initialize postgres, but as soon as you see `parse-server running on port 1337.`, it's ready to go. See [here](https://github.com/netreconlab/parse-hipaa#getting-started) for details
4. If you would like to use mongo instead of postgres, in step 3, type `docker-compose -f docker-compose.mongo.yml up` instead of `docker-compose up`

## Fork this repo to get the modified OCKSample app

1. Fork [CareKitSample-ParseCareKit](https://github.com/netreconlab/ParseCareKit)
2. Open `OCKSample.xcodeproj` in Xcode
3. You may need to configure your "Team" and "Bundle Identifier" in "Signing and Capabilities"
4. Run the app and data will synchronize with parse-hipaa via http://localhost:1337/parse automatically
5. You can edit Parse server setup in the ParseCareKit.plist file under "Supporting Files" in the Xcode browser

## View your data in Parse Dashboard

### Heroku
The easiest way to setup your dashboard is using the [one-button-click](https://github.com/netreconlab/parse-hipaa-dashboard#heroku) deployment method for [parse-hipaa-dashboard](https://github.com/netreconlab/parse-hipaa-dashboard).

### Docker
Parse Dashboard is the easiest way to view your data in the Cloud (or local machine in this example) and comes with [parse-hipaa](https://github.com/netreconlab/parse-hipaa). To access:
1. Open your browser and go to http://localhost:4040/dashboard
2. Username: `parse`
3. Password: `1234`
4. Be sure to refresh your browser to see new changes synched from your CareKitSample app

Note that CareKit data is extremely sensitive and you are responsible for ensuring your parse-server meets HIPAA compliance.

## Transitioning the sample app to a production app
If you plan on using this app as a starting point for your produciton app. Once you have your parse-hipaa server in the Cloud behind ssl, you should open `ParseCareKit.plist` in Xcode and change the value for `Server` to point to your server(s) in the Cloud. You should also open `Info.plist` in Xcode and remove `App Transport Security Settings` and any key/value pairs under it as this was only in place to allow you to test the sample app to connect to a server setup on your local machine. iOS apps do not allow non-ssl connections in production, and even if you find a way to connect to non-ssl servers, it would not be HIPAA compliant.

### Extra scripts for optimized Cloud queries
You should run the extra scripts outlined on parse-hipaa [here](https://github.com/netreconlab/parse-hipaa#running-in-production-for-parsecarekit).

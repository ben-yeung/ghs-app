//
//  AppDelegate.swift
//  TimelinesSwift
//
//  Created by Ben 05/26/17.
//  Copyright (c) 2017 AppClub. All rights reserved.
// testing


import UIKit
import TwitterKit
import SwiftyJSON
import UserNotifications
import Firebase
import FirebaseMessaging

var notifChecked:Bool = true

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var keys: NSDictionary?
    
    var GoogleAPI: String?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if let path = Bundle.main.path(forResource: "keys", ofType: "plist") {
               keys = NSDictionary(contentsOfFile: path)
           }
        if let dict = keys {
            GoogleAPI = dict["GoogleKey"] as? String
        }
        
        
        FirebaseApp.configure()
        Messaging.messaging().delegate = self as? MessagingDelegate
        CalendarViewController().createSearch()
        
        
        //If the app is opened via a notification, it will redirect users to the notification view
        if let option = launchOptions {
            let info = option[UIApplicationLaunchOptionsKey.remoteNotification]
            if (info != nil) {
                //From Notification
            }}
        
        //Appearance settings to allow changes to NavBar
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)

        //calls PushNotif function to initiate service/prompt
         registerForPushNotifications()
        
        
        return true
    }
    
    //Actions to run when the app is opened by a notification (Move to notification view controller)
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    
            print("notifcation opened")
        
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let notifVC = storyBoard.instantiateViewController(withIdentifier: "NotificationsVC")
            self.window?.rootViewController?.present(notifVC, animated: true, completion: nil)
            notifChecked = false //This dicates the logo of the notificaiton button to show if users have checked the latest notif
    
    }

    
    func application(_ application: UIApplication,
                     open url: URL, sourceApplication: String?, annotation: Any) -> Bool {

        return true
    }
    
    
    func registerForPushNotifications() {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            print("Permission granted: \(granted)")
            
            //guards if a user decides to turn notifications for app off
            guard granted else { return }
            self.getNotificationSettings()
        }
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            print("Notification settings: \(settings)")
            
            //verifies that the user allowed notifications
            guard settings.authorizationStatus == .authorized else { return }
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    

    
    //token is made per device/user to create an "address" for push notifications to send to
    //TEST TOKEN BEN'S IPHONE: 2e167f7a992d2419a39549901ea7cd55f33463c4ab0eb919eb38d3f34801ad6b
    //OR cvKRRdmfViw:APA91bEol9BHCmfTZcYzTjR-OsA4jO-xjUGW1_07NmFSHXowY8adHFeS2z6oRovBAmdtaVCvXEqKKoMC6PGMELtHcMtaOHIlA-DJ9u7Y27zFyBafDherEvfmZCcMg-QAPQ79aQAPw8fk
    func application(_ : UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        
        let token = tokenParts.joined()
        print("Device Token: \(token)")
        
        InstanceID.instanceID().instanceID { (result, error) in
            if let error = error {
                print("Error fetching remote instange ID: \(error)")
            } else if let result = result {
                print("Remote instance ID token: \(result.token)")
            }
        }
        
        Messaging.messaging().apnsToken = deviceToken
        
        
        
        
    }
    
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
       
        print("Failed to register: \(error)")
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        CalendarViewController().createSearch()
    }
    

}


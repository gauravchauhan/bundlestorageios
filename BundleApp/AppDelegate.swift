//
//  AppDelegate.swift
//  BundleApp
//
//  Created by Vijay Mishra on 12/08/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit
import GoogleSignIn
import GoogleMaps
import GooglePlaces
import RESideMenu
import Fabric
import Crashlytics
import BraintreeDropIn
import Braintree
import UserNotifications
import Firebase
import FirebaseInstanceID
import FirebaseMessaging

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate , UNUserNotificationCenterDelegate, MessagingDelegate {

    var window: UIWindow?
    let storyboard = UIStoryboard(name: "Main", bundle: nil)


    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //Add the fb  and google signin to the app with the appID's
        FirebaseApp.configure()
        BTAppSwitch.setReturnURLScheme("com.jft.BundleApp.payments")
        GIDSignIn.sharedInstance().clientID = Constants.Google_Credentials.googleClient_id
        GMSServices.provideAPIKey("AIzaSyDdDIw3AV25HSDH2e9V6RfurCV4V1uu61k")
        GMSPlacesClient.provideAPIKey("AIzaSyB962fIXTbtjlO_pf5vFk1yYBBPCp5NGg8")
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        let navigationController = UINavigationController(rootViewController: mainViewController)
        let sideMenu : RESideMenu = RESideMenu(contentViewController: navigationController , leftMenuViewController: LeftMenuViewController(), rightMenuViewController: LeftMenuViewController())
        self.window?.rootViewController = sideMenu
        Fabric.with([Crashlytics.self])
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            // For iOS 10 data message (sent via FCM
            
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        Messaging.messaging().delegate = self
        
//        FirebaseApp.configure()
        
        return true
    }
    
   
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        if url.scheme?.localizedCaseInsensitiveCompare("com.jft.BundleApp.payments") == .orderedSame {
            return BTAppSwitch.handleOpen(url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String)
        }
        return false
    }
    
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if url.scheme?.localizedCaseInsensitiveCompare("com.jft.BundleApp.payments") == .orderedSame {
            return BTAppSwitch.handleOpen(url, sourceApplication: sourceApplication) && (GIDSignIn.sharedInstance()?.handle(url as URL))!
        }
        return false
    }
    
    func application(application: UIApplication,
                     openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        
        //Register for social logins(Fb, Google)
        return (GIDSignIn.sharedInstance()?.handle(url as URL))!
    }
    
    
    //MARK:- notification Delegate
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        let token = Messaging.messaging().fcmToken
        print("FCM token: \(token ?? "")")
        //        Singelton.sharedInstance.FCM_Token = token
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        print("Did Recive Remote Notification   \(userInfo as NSDictionary)")
    }
    
    func applicationReceivedRemoteMessage(_ remoteMessage: MessagingRemoteMessage) {
        print("remoteMessage.appData   \(remoteMessage.appData)")
    }
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    //MARK: token
    
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
    }
    
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("In Notification   \(notification.request.content.userInfo  as NSDictionary)")
//        let notificationData = notification.request.content.userInfo as NSDictionary
//        print(notification.request.content.userInfo as NSDictionary)
//        if notification.request.content.userInfo["mydata"] != nil{
//            let data = (notificationData.value(forKey: "mydata")as! String).data(using:String.Encoding.ascii, allowLossyConversion: false)
//            let responseJSON = try? JSONSerialization.jsonObject(with: data!, options: [])
//            print("response JSon \(String(describing: responseJSON))")
//            NotificationCenter.default.post(name: Notification.Name(rawValue:"NearByViewController"), object: nil, userInfo: responseJSON as! [String : Any])
//        }
        completionHandler([.alert])
    }
    
    //MARK:-  If you support iOS 8, add the following method.
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


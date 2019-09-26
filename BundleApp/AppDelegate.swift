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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let storyboard = UIStoryboard(name: "Main", bundle: nil)


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //Add the fb  and google signin to the app with the appID's
        Singelton.sharedInstance.location.setLatLong()
        GIDSignIn.sharedInstance().clientID = Constants.Google_Credentials.googleClient_id
        GMSServices.provideAPIKey("AIzaSyDdDIw3AV25HSDH2e9V6RfurCV4V1uu61k")
        GMSPlacesClient.provideAPIKey("AIzaSyB962fIXTbtjlO_pf5vFk1yYBBPCp5NGg8")  
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        let navigationController = UINavigationController(rootViewController: mainViewController)
        let sideMenu : RESideMenu = RESideMenu(contentViewController: navigationController , leftMenuViewController: LeftMenuViewController(), rightMenuViewController: LeftMenuViewController())
        self.window?.rootViewController = sideMenu
        
        return true
    }
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        //Register for social logins(Fb, Google)
        
        return (GIDSignIn.sharedInstance()?.handle(url as URL))!
    }
    
    func application(application: UIApplication,
                     openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        
        //Register for social logins(Fb, Google)
        return (GIDSignIn.sharedInstance()?.handle(url as URL))!
    }
    
    

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


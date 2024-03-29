//
//  AppDelegate.swift
//  proteins
//
//  Created by ANASTASIA on 7/19/19.
//  Copyright © 2019 ANASTASIA. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
// https://medium.com/@stasost/ios-root-controller-navigation-3625eedbbff useful resource
    
  //  https://www.freecodecamp.org/news/how-to-handle-internet-connection-reachability-in-swift-34482301ea57/ -> for activity in case offline

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        /*
         let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
         let navigationController = mainStoryBoard.instantiateViewController(withIdentifier: "NavController") as! UINavigationController
         let appDelegate = UIApplication.shared.delegate as! AppDelegate
         appDelegate.window?.rootViewController = navigationController

         */
        

        
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        
        Thread.sleep(forTimeInterval: 3.0)
        
    
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
/* This might be totally wrong to be honest*/
       // seems like there are leaks / need to figure this out https://guides.codepath.com/ios/View-Controller-Lifecycle
        
    
        let topController = UIApplication.topViewController()
        print("moving to background from ", topController!)
        topController?.navigationController?.popToRootViewController(animated: false)
        
/* This might be totally wrong to be honest*/
        
        
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
//not sure if this works
extension UIApplication
{
    class func topViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = base as? UINavigationController
        {
            let top = topViewController(navigationController.visibleViewController)
            return top
        }
        
        if let tabController = base as? UITabBarController
        {
            if let selected = tabController.selectedViewController
            {
                let top = topViewController(selected)
                return top
            }
        }
        
        if let presented = base?.presentedViewController
        {
            let top = topViewController(presented)
            return top
        }
        return base
    }
}


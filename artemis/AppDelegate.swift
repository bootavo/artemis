//
//  AppDelegate.swift
//  youtube
//
//  Created by admin on 22/03/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import SwiftyUserDefaults

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //Keyboard
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = true
        
        //Add Navigation View to the App
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let loginController = LoginController()
        let navLoginController = UINavigationController(rootViewController: loginController)
        
        let tabBarController = TabBarController()
        let navTabBarController = UINavigationController(rootViewController: tabBarController)
        
        //Navigation Bar Colors
        UINavigationBar.appearance().barTintColor = UIColor.primaryDarkColor()
        UINavigationBar.appearance().isTranslucent = false
        navTabBarController.automaticallyAdjustsScrollViewInsets = true
        
        let statusBar = UIApplication.shared.value(forKey: "statusBar") as! UIView
        statusBar.backgroundColor = UIColor.primaryDarkColor()
        
        UIApplication.shared.isStatusBarHidden = false
        UIApplication.shared.statusBarStyle = .lightContent
        
        if verifyUser() {
            window?.rootViewController = navTabBarController
        }else {
            window?.rootViewController = navLoginController
        }
        return true
    }
    
    func verifyUser() -> Bool {
        var state = false
        if let code = Defaults[.employee_code], let _ = Defaults[.name], let _ = Defaults[.patternLastName], let _ = Defaults[.matternLastName] {
            if code != "" {
                state = true
            }else {
                state = false
            }
        }
        return state
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


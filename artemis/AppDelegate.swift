//
//  AppDelegate.swift
//  youtube
//
//  Created by admin on 22/03/18.
//  Copyright © 2018 GAP GLOBAL SOLUTIONS S.A.C. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = true
        
        //Add Navigation View to the App
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let loginController = LoginController(collectionViewLayout: UICollectionViewFlowLayout())
        
        let homeController = HomeController(collectionViewLayout: UICollectionViewFlowLayout())
        
        let youtubeController = YoutubeController(collectionViewLayout: UICollectionViewFlowLayout())
        
        //window?.rootViewController = UINavigationController(rootViewController: loginControllerTest)
        
        let loginControllerTest = LoginControllerTest()
        let navController = UINavigationController(rootViewController: loginControllerTest)
        window?.rootViewController = navController
        
        UINavigationBar.appearance().barTintColor = UIColor.primaryColor()
        
        //StatusBar title white for all Controllers
        //application.statusBarStyle = .lightContent // This need add in info.plist -> View controller-based status bar appearance
        
        let statusBarBackgroundView = UIView()
        statusBarBackgroundView.backgroundColor = UIColor.primaryDarkColor()
        window?.addSubview(statusBarBackgroundView)
        
        //Márgenes de status bar
        let size: String = ScreenHelper.create().getDevice()
        window?.addConstraintsWithFormat(format: "H:|[v0]|", views: statusBarBackgroundView)
        window?.addConstraintsWithFormat(format: "V:|[v0(\(size))]", views: statusBarBackgroundView)
        
        return true
        
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


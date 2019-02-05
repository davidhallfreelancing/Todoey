//
//  AppDelegate.swift
//  Todoey
//
//  Created by Unprivileged on 2019-01-29.
//  Copyright © 2019 Unprivileged. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
        print("DidFinishLaunchingWithOptions")
        
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
        return true
    }


    func applicationWillResignActive(_ application: UIApplication) {

    }


    func applicationDidEnterBackground(_ application: UIApplication) {
        print("ApplicationDidEnterBackground")

    }


    func applicationWillEnterForeground(_ application: UIApplication) {
    
    }


    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }


    func applicationWillTerminate(_ application: UIApplication) {
        print("ApplicationWillTerminate")
    }



}

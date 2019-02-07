//
//  AppDelegate.swift
//  Todoey
//
//  Created by Unprivileged on 2019-01-29.
//  Copyright © 2019 Unprivileged. All rights reserved.
//

import UIKit
import RealmSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        print(Realm.Configuration.defaultConfiguration.fileURL ?? "Unable to locate realm file url")
        
        do {
            _ = try Realm()
        } catch {
            print("Error initializing a new realm, \(error)")
        }
        
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
    

}

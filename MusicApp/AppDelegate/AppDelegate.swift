//
//  AppDelegate.swift
//  MusicApp
//
//  Created by Praful Mahajan on 13/07/20.
//  Copyright © 2020 prafulmahajan. All rights reserved.
//

import UIKit
import CoreData
import GoogleSignIn
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GIDSignIn.sharedInstance().clientID = Generic.kGIDSignInClientId
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        let authToken = LocalStore.getAuthToken()
        if authToken.count > 0 {
            if let vc = Generic.getViewControllerFromStoryBoard(type: WelcomeViewController.self, storyBoard: .MAIN) {
                self.window?.rootViewController = vc
            }
        } else {
            let vc = Generic.getNavigationControllerFromStoryBoard(container: .LoginContainer, storyBoard: .MAIN)
            self.window?.rootViewController = vc
        }
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        if url.scheme != nil && url.scheme!.hasPrefix("fb") && url.host ==  "authorize" {
            let handled: Bool = ApplicationDelegate.shared.application(app, open: url, sourceApplication: options[.sourceApplication] as? String, annotation: options[.annotation])
            return handled
        }
        return GIDSignIn.sharedInstance().handle(url)
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "MusicApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    //MARK: AppDelegates Instance
    class var sharedInstance: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

}


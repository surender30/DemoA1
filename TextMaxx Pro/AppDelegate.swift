//
//  AppDelegate.swift
//  TextMaxx Pro
//
//  Created by surender on 04/10/16.
//  Copyright © 2016 Trigma. All rights reserved.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift
import UserNotifications
import TSMessages
import Fabric
import Crashlytics
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate {

    var window: UIWindow?
    var viewController = UIViewController()
    var cellnumber = String()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UserDefaults.standard.set(false, forKey: "updateApp")
        Fabric.with([Crashlytics.self])
        
        UserDefaults.standard.set("", forKey: "cell")
        UIApplication.shared.statusBarStyle = .lightContent
        IQKeyboardManager.sharedManager().enable = true
        
        if UserDefaults.standard.bool(forKey: "Login") == true
        {
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let main = storyboard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
         self.window!.rootViewController = main
        }
        
        if #available(iOS 10.0, *) {
            let center  = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options: [.sound, .alert, .badge]) { (granted, error) in
                if error == nil{
                    UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.sound, .alert, .badge], categories: nil))
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        } else {
            // Fallback on earlier versions
        }
        
        // Override point for customization after application launch.
        return true
    }
    
    
    func changeWithTabBarControler() {
        // let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let viewController = storyBoard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
        self.window?.rootViewController = viewController
        
    }
    
    func changeWithInboxTabBarControler() {
        // let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let viewController = storyBoard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
        self.window?.rootViewController = viewController
    }
    
    func changeInbox()
    {
        let tabbar = self.window?.rootViewController as? TabBarVC
        tabbar?.selectedIndex = 0
    }
    
    func changeChateDetail()
    {
        let tabbar = self.window?.rootViewController as? TabBarVC
        tabbar?.selectedIndex = 1
        let objInboxVC = tabbar?.viewControllers?[1]
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let ChatviewController = storyBoard.instantiateViewController(withIdentifier: "chatDetailVC") as! chatDetailVC
        objInboxVC?.childViewControllers[0].navigationController?.pushViewController(ChatviewController, animated: true)
    }
    
    func LoginVC() {
        // let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.window?.rootViewController = viewController
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("DEVICE TOKEN = \(deviceToken)")
        var token = ""
        for i in 0..<deviceToken.count {
            token = token + String(format: "%02.2hhx", arguments: [deviceToken[i]])
        }
        print(token)
        UserDefaults.standard.setValue(token, forKey: "deviceToken")
        UserDefaults.standard.synchronize()
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
 UserDefaults.standard.setValue("8d1eb6a7a72d48590ef47aea551cf6c961ba6cc2608d3ac81654737724da351b", forKey: "deviceToken")
        UserDefaults.standard.synchronize()

        print(error)
    }
    
    //    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
    //        print(userInfo)
    //    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if let aps = response.notification.request.content.userInfo as? NSDictionary{
            
            if (aps.value(forKeyPath: "aps.data.type") as! String == "PNT_AWAIT")
            {
               changeInbox()
            }
            else
            {
                UserDefaults.standard.set(aps.value(forKeyPath: "aps.data.cell") as! String, forKey: "cell")
                UserDefaults.standard.set(aps.value(forKeyPath: "aps.data.label") as! String, forKey: "label")
                UserDefaults.standard.set(true, forKey: "Chat")
                changeChateDetail()
            }
        }
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler(
            [
             UNNotificationPresentationOptions.sound
             ])
        
        if let aps = notification.request.content.userInfo as? NSDictionary {
            
            let tabbar = self.window?.rootViewController as? TabBarVC

            if (aps.value(forKeyPath: "aps.data.type") as! String == "PNT_AWAIT")
            {
                if ((tabbar?.selectedViewController as! UINavigationController).visibleViewController?.isKind(of: HomeVC.self))!
                {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "await"), object: nil)
                }
                else
                {
                    // TimeInterval(TSMessageNotificationDuration.automatic.rawValue)
                    
                    TSMessage.showNotification(in: self.window!.rootViewController,
                                               title: aps.value(forKeyPath: "aps.alert.title") as! String!,
                                               subtitle: aps.value(forKeyPath: "aps.alert.body") as! String!,
                                               image:nil,
                                               type: TSMessageNotificationType.message,
                                               duration: 3.0,
                                               callback: {
                                                
                                              self.changeInbox()
                                                
                    },
                                               buttonTitle: "",
                                               buttonCallback: {
                                                
                                                
                                                () -> Void in },
                                               at: TSMessageNotificationPosition.top,
                                               canBeDismissedByUser: false)
                }
            }
            else{
                UserDefaults.standard.set(aps.value(forKeyPath: "aps.data.cell") as! String, forKey: "cell")
                UserDefaults.standard.set(aps.value(forKeyPath: "aps.data.label") as! String, forKey: "label")
                UserDefaults.standard.set(true, forKey: "Chat")
                
                if ((tabbar?.selectedViewController as! UINavigationController).visibleViewController?.isKind(of: chatDetailVC.self))!
                {
                    if cellnumber == aps.value(forKeyPath: "aps.data.cell") as! String
                    {
                         NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Chat"), object: nil)
                    }
                    else{
                        TSMessage.showNotification(in: self.window!.rootViewController,
                                                   title: aps.value(forKeyPath: "aps.alert.title") as! String!,
                                                   subtitle: aps.value(forKeyPath: "aps.alert.body") as! String!,
                                                   image:nil,
                                                   type: TSMessageNotificationType.message,
                                                   duration: 3.0,
                                                   callback: {
                                                    self.changeChateDetail()
                                                    
                                                    
                        },
                                                   buttonTitle: "",
                                                   buttonCallback: {
                                                    
                                                    () -> Void in },
                                                   at: TSMessageNotificationPosition.top,
                                                   canBeDismissedByUser: false)
                    }
                }
                else
                {
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Inbox"), object: nil)
                    
                    TSMessage.showNotification(in: self.window!.rootViewController,
                                               title: aps.value(forKeyPath: "aps.alert.title") as! String!,
                                               subtitle: aps.value(forKeyPath: "aps.alert.body") as! String!,
                                               image:nil,
                                               type: TSMessageNotificationType.message,
                                               duration: 3.0,
                                               callback: {
                                                self.changeChateDetail()

                                                
                    },
                                               buttonTitle: "",
                                               buttonCallback: {
                                                
                                                
                                                () -> Void in },
                                               at: TSMessageNotificationPosition.top,
                                               canBeDismissedByUser: false)
                }

            }
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        UserDefaults.standard.set(false, forKey: "Chat")
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
          application.applicationIconBadgeNumber = 0
        
        UserDefaults.standard.set(true, forKey: "updateApp")
        
//        if  UserDefaults.standard.bool(forKey: "updateApp") == true{
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "update"), object: nil)
//        }
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
       
        
        application.applicationIconBadgeNumber = 0
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        UserDefaults.standard.set(false, forKey: "Chat")

        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
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
        let container = NSPersistentContainer(name: "TextMaxx_Pro")
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

}

extension String {
    public func tochangePhoneNumber() -> String {
        return self.replacingOccurrences(of: "(\\d{3})(\\d{3})(\\d+)", with: "($1) $2-$3", options: .regularExpression, range: nil)
    }
}



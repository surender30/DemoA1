//
//  DBFunctions.swift
//  Qperz
//
//  Created by Arshdeep Kaur on 11/01/16.
//  Copyright © 2016 Alchemist Infosystems. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DBFunctions {
    class var sharedDBFunctions : DBFunctions {
        struct Static {
            static let instance : DBFunctions = DBFunctions()
        }
        return Static.instance
    }
    
    func saveProfileData(arr_Profile:NSMutableArray, isUpdate: Bool) {
        //1
        
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        
        
        //        if self.fetchUserProfileFromDB(String(describing: UserDefaults.standard.value(forKey: loggedInUserId)!)).count == 0 {
        //2
        
        //        }
        //        else {
        //            contact = self.fetchUserProfileFromDB(String(describing: UserDefaults.standard.value(forKey: loggedInUserId)!))[0] as! Contact
        //        }
        let entity =  NSEntityDescription.entity(forEntityName: "Profile",
                                                 in:
            managedContext)
        for i in 0..<arr_Profile.count
        {
            let profile = NSManagedObject(entity: entity!,
                                           insertInto:managedContext) as! Profile
            
            if (arr_Profile.object(at: i) as! NSDictionary).value(forKey: "cell") as? String! != nil{
                profile.cell = ((arr_Profile.object(at: i) as! NSDictionary).value(forKey: "cell") as? String!)
            }
            else{
                profile.cell = ""
            }
            
            if (arr_Profile.object(at: i) as! NSDictionary).value(forKey: "accepted_account") as? String! != nil{
                profile.accepted_account = ((arr_Profile.object(at: i) as! NSDictionary).value(forKey: "accepted_account") as? String!)
            }
            else{
                profile.accepted_account = ""
            }
            
            if (arr_Profile.object(at: i) as! NSDictionary).value(forKey: "accepted_market") as? String! != nil{
                profile.accepted_market = ((arr_Profile.object(at: i) as! NSDictionary).value(forKey: "accepted_market") as? String!)
            }
            else{
                profile.accepted_market = ""
            }
            
            if (arr_Profile.object(at: i) as! NSDictionary).value(forKey: "accepts_market") as? String! != nil{
                profile.accepts_market = ((arr_Profile.object(at: i) as! NSDictionary).value(forKey: "accepts_market") as? String!)
            }
            else{
                profile.accepts_market = ""
            }
            
            if (arr_Profile.object(at: i) as! NSDictionary).value(forKey: "accepts_account") as? String! != nil{
                profile.accepts_account = ((arr_Profile.object(at: i) as! NSDictionary).value(forKey: "accepts_account") as? String!)
            }
            else{
                profile.accepts_account = ""
            }
            
            if (arr_Profile.object(at: i) as! NSDictionary).value(forKey: "account_number") as? String! != nil{
                profile.account_number = ((arr_Profile.object(at: i) as! NSDictionary).value(forKey: "account_number") as? String!)
            }
            else{
                profile.account_number = ""
            }
            
            if (arr_Profile.object(at: i) as! NSDictionary).value(forKey: "account_on_file") as? String! != nil{
                profile.account_on_file = ((arr_Profile.object(at: i) as! NSDictionary).value(forKey: "account_on_file") as? String!)
            }
            else{
                profile.account_on_file = ""
            }
            
            if (arr_Profile.object(at: i) as! NSDictionary).value(forKey: "awaiting") as? String! != nil{
                profile.awaiting = ((arr_Profile.object(at: i) as! NSDictionary).value(forKey: "awaiting") as? String!)
            }
            else{
                profile.awaiting = ""
            }
            
            if (arr_Profile.object(at: i) as! NSDictionary).value(forKey: "carrier") as? String! != nil{
                profile.carrier = ((arr_Profile.object(at: i) as! NSDictionary).value(forKey: "carrier") as? String!)
            }
            else{
                profile.carrier = ""
            }
            
            if (arr_Profile.object(at: i) as! NSDictionary).value(forKey: "dob") as? String! != nil{
                profile.dob = ((arr_Profile.object(at: i) as! NSDictionary).value(forKey: "dob") as? String!)
            }
            else{
                profile.dob = ""
            }
            
            if (arr_Profile.object(at: i) as! NSDictionary).value(forKey: "employees") as? String! != nil{
                profile.employees = ((arr_Profile.object(at: i) as! NSDictionary).value(forKey: "employees") as? String!)
            }
            else{
                profile.employees = ""
            }
            
//            if (arr_Profile.object(at: i) as! NSDictionary).value(forKey: "error") as? String! != nil{
//                profile.error = ((arr_Profile.object(at: i) as! NSDictionary).value(forKey: "error") as? String!)
//            }
//            else{
//                profile.error = ""
//            }
            
            if (arr_Profile.object(at: i) as! NSDictionary).value(forKey: "ivr") as? String! != nil{
                profile.ivr = ((arr_Profile.object(at: i) as! NSDictionary).value(forKey: "ivr") as? String!)
            }
            else{
                profile.ivr = ""
            }
            
            
            if (arr_Profile.object(at: i) as! NSDictionary).value(forKey: "label") as? String! != nil{
                profile.label = ((arr_Profile.object(at: i) as! NSDictionary).value(forKey: "label") as? String!)
            }
            else{
                profile.label = ""
            }
            
            if (arr_Profile.object(at: i) as! NSDictionary).value(forKey: "language") as? String! != nil{
                profile.language = ((arr_Profile.object(at: i) as! NSDictionary).value(forKey: "language") as? String!)
            }
            else{
                profile.language = ""
            }
            
            if (arr_Profile.object(at: i) as! NSDictionary).value(forKey: "marketed_when") as? String! != nil{
                profile.marketed_when = ((arr_Profile.object(at: i) as! NSDictionary).value(forKey: "marketed_when") as? String!)
            }
            else{
                profile.marketed_when = ""
            }
            
            if (arr_Profile.object(at: i) as! NSDictionary).value(forKey: "pending_account_opt_in") as? String! != nil{
                profile.pending_account_opt_in = ((arr_Profile.object(at: i) as! NSDictionary).value(forKey: "pending_account_opt_in") as? String!)
            }
            else{
                profile.pending_account_opt_in = ""
            }
            
            if (arr_Profile.object(at: i) as! NSDictionary).value(forKey: "pending_market_opt_in") as? String! != nil{
                profile.pending_market_opt_in = ((arr_Profile.object(at: i) as! NSDictionary).value(forKey: "pending_market_opt_in") as? String!)
            }
            else{
                profile.pending_market_opt_in = ""
            }
            
            if (arr_Profile.object(at: i) as! NSDictionary).value(forKey: "received") as? String! != nil{
                profile.received = ((arr_Profile.object(at: i) as! NSDictionary).value(forKey: "received") as? String!)
            }
            else{
                profile.received = ""
            }
            
            if (arr_Profile.object(at: i) as! NSDictionary).value(forKey: "recently_marketed") as? String! != nil{
                profile.recently_marketed = ((arr_Profile.object(at: i) as! NSDictionary).value(forKey: "recently_marketed") as? String!)
            }
            else{
                profile.recently_marketed = ""
            }
            
            if (arr_Profile.object(at: i) as! NSDictionary).value(forKey: "sent") as? String! != nil{
                profile.sent = ((arr_Profile.object(at: i) as! NSDictionary).value(forKey: "sent") as? String!)
            }
            else{
                profile.sent = ""
            }
            
            if (arr_Profile.object(at: i) as! NSDictionary).value(forKey: "stopped") as? String! != nil{
                profile.stopped = ((arr_Profile.object(at: i) as! NSDictionary).value(forKey: "stopped") as? String!)
            }
            else{
                profile.stopped = ""
            }
            
            if (arr_Profile.object(at: i) as! NSDictionary).value(forKey: "tags") as? String! != nil{
                profile.tags = ((arr_Profile.object(at: i) as! NSDictionary).value(forKey: "tags") as? String!)
            }
            else{
                profile.tags = ""
            }
            
            if (((arr_Profile.object(at: i) as! NSDictionary).value(forKey: "variables") as? NSArray)?.count)! > 0
            {
                profile.variables = (arr_Profile.object(at: i) as! NSDictionary).value(forKey: "variables") as? NSArray
            }
            else{
                profile.variables = []  as Array as NSObject?
            }
            
            if (arr_Profile.object(at: i) as! NSDictionary).value(forKey: "web") as? String! != nil{
                profile.web = ((arr_Profile.object(at: i) as! NSDictionary).value(forKey: "web") as? String!)
            }
            else{
                profile.web = ""
            }
        }
        
        do {
            managedContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
            try appDelegate.persistentContainer.viewContext.save()
            
        }
        catch {
            fatalError("Failure to save context: \(error)")
        }
        
        
        //5
        // Save data in managed object context.
        
        
        //self.saveLocationsForUserInDb(data.valueForKey("Location_List") as! NSArray, userProfile: userProfile)
    }

    
    
    func saveAccountsDb(arr_Accounts:NSMutableArray, isUpdate: Bool) {
        //1
        
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
    
        let entity =  NSEntityDescription.entity(forEntityName: "Accounts",
                                                 in:
            managedContext)
        
        for i in 0..<arr_Accounts.count
        {
            let accounts = NSManagedObject(entity: entity!,
                                          insertInto:managedContext) as! Accounts
            
            if (arr_Accounts.object(at: i) as! NSDictionary).value(forKey: "customer") as? String! != nil{
                accounts.customer = ((arr_Accounts.object(at: i) as! NSDictionary).value(forKey: "customer") as? String!)
            }
            else{
                accounts.customer = ""
            }
            
            if (arr_Accounts.object(at: i) as! NSDictionary).value(forKey: "holder") as? String! != nil{
                accounts.holder = ((arr_Accounts.object(at: i) as! NSDictionary).value(forKey: "holder") as? String!)
            }
            else{
                accounts.holder = ""
            }
            
            if (arr_Accounts.object(at: i) as! NSDictionary).value(forKey: "issuer") as? String! != nil{
                accounts.issuer = ((arr_Accounts.object(at: i) as! NSDictionary).value(forKey: "issuer") as? String!)
            }
            else{
                accounts.issuer = ""
            }
            
            if (arr_Accounts.object(at: i) as! NSDictionary).value(forKey: "label") as? String! != nil{
                accounts.label = ((arr_Accounts.object(at: i) as! NSDictionary).value(forKey: "label") as? String!)
            }
            else{
                accounts.label = ""
            }
            
            if (arr_Accounts.object(at: i) as! NSDictionary).value(forKey: "last_four") as? String! != nil{
                accounts.last_four = ((arr_Accounts.object(at: i) as! NSDictionary).value(forKey: "last_four") as? String!)
            }
            else{
                accounts.last_four = ""
            }
            
            if (arr_Accounts.object(at: i) as! NSDictionary).value(forKey: "token") as? String! != nil{
                accounts.token = ((arr_Accounts.object(at: i) as! NSDictionary).value(forKey: "token") as? String!)
            }
            else{
                accounts.token = ""
            }
            
            if (arr_Accounts.object(at: i) as! NSDictionary).value(forKey: "type") as? String! != nil{
                accounts.type = ((arr_Accounts.object(at: i) as! NSDictionary).value(forKey: "type") as? String!)
            }
            else{
                accounts.type = ""
            }
        }
        
        do {
            managedContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
            try appDelegate.persistentContainer.viewContext.save()
            
        }
        catch {
            fatalError("Failure to save context: \(error)")
        }
        
        
        //5
        // Save data in managed object context.
        
        
        //self.saveLocationsForUserInDb(data.valueForKey("Location_List") as! NSArray, userProfile: userProfile)
    }

    
    
    
    // MARK: - Save contact List
    func saveContactsDb(arr_contact:NSMutableArray, isUpdate: Bool) {
        //1
        
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        

        
//        if self.fetchUserProfileFromDB(String(describing: UserDefaults.standard.value(forKey: loggedInUserId)!)).count == 0 {
            //2
        
//        }
//        else {
//            contact = self.fetchUserProfileFromDB(String(describing: UserDefaults.standard.value(forKey: loggedInUserId)!))[0] as! Contact
//        }
        let entity =  NSEntityDescription.entity(forEntityName: "Contact",
                                                 in:
            managedContext)
        for i in 0..<arr_contact.count
        {
            let contact = NSManagedObject(entity: entity!,
                                      insertInto:managedContext) as! Contact

            if (arr_contact.object(at: i) as! NSDictionary).value(forKey: "verified") as? String! != nil{
                contact.verified = ((arr_contact.object(at: i) as! NSDictionary).value(forKey: "verified") as? String!)
            }
            else{
                contact.verified = ""
            }
            
            if (arr_contact.object(at: i) as! NSDictionary).value(forKey: "account_number") as? String! != nil
            {
                 contact.accountNumber = ((arr_contact.object(at: i) as! NSDictionary).value(forKey: "account_number") as? String!)
            }
            else{
                contact.accountNumber = ""
            }
            
            if (arr_contact.object(at: i) as! NSDictionary).value(forKey: "cell") as? String! != nil{
                contact.cell = ((arr_contact.object(at: i) as! NSDictionary).value(forKey: "cell") as? String!)
            }
            else{
                contact.cell = ""
            }
            
            if (arr_contact.object(at: i) as! NSDictionary).value(forKey: "label") as? String! != nil
            {
                contact.label = ((arr_contact.object(at: i) as! NSDictionary).value(forKey: "label") as? String!)
            }
            else
            {
                contact.label = ""
            }
        }
        
        do {
            managedContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
            try appDelegate.persistentContainer.viewContext.save()
            
        }
        catch {
            fatalError("Failure to save context: \(error)")
        }
        
        
            //5
        // Save data in managed object context.
        
        
        //self.saveLocationsForUserInDb(data.valueForKey("Location_List") as! NSArray, userProfile: userProfile)
    }
    
    func saveRecentsDb(arr_Recent:NSMutableArray, isUpdate: Bool) {
        //1
        
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext

        let entity =  NSEntityDescription.entity(forEntityName: "Recent",
                                                 in:
            managedContext)
        for i in 0..<arr_Recent.count
        {
            let Recent = NSManagedObject(entity: entity!,
                                          insertInto:managedContext) as! Recent
            
            if (arr_Recent.object(at: i) as! NSDictionary).value(forKey: "verified") as? String! != nil{
                Recent.account_number = ((arr_Recent.object(at: i) as! NSDictionary).value(forKey: "account_number") as? String!)
            }
            else{
                Recent.account_number = ""
            }
            
            if (arr_Recent.object(at: i) as! NSDictionary).value(forKey: "cell") as? String! != nil
            {
                Recent.cell = ((arr_Recent.object(at: i) as! NSDictionary).value(forKey: "account_number") as? String!)
            }
            else{
                Recent.cell = ""
            }
            
            if (arr_Recent.object(at: i) as! NSDictionary).value(forKey: "label") as? String! != nil{
                Recent.label = ((arr_Recent.object(at: i) as! NSDictionary).value(forKey: "cell") as? String!)
            }
            else{
                Recent.label = ""
            }
        }
        
        do {
            managedContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
            try appDelegate.persistentContainer.viewContext.save()
            
        }
        catch {
            fatalError("Failure to save context: \(error)")
        }
        
        
        //5
        // Save data in managed object context.
        
        
        //self.saveLocationsForUserInDb(data.valueForKey("Location_List") as! NSArray, userProfile: userProfile)
    }

    
    // MARK: - Save in AwaitList
    func saveAwaitsList(arr_await:NSMutableArray, isUpdate: Bool) {
        //1
        
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity =  NSEntityDescription.entity(forEntityName: "Await",
                                                 in:managedContext)
        for i in 0..<arr_await.count
        {
            let Await = NSManagedObject(entity: entity!,
                                          insertInto:managedContext) as! Await
            
            if (arr_await.object(at: i) as! NSDictionary).value(forKey: "account_number") as? String! != nil{
                Await.accountNumber = ((arr_await.object(at: i) as! NSDictionary).value(forKey: "account_number") as? String!)
            }
            else{
                Await.accountNumber = ""
            }
            
            if (arr_await.object(at: i) as! NSDictionary).value(forKey: "cell") as? String! != nil
            {
                Await.cell = ((arr_await.object(at: i) as! NSDictionary).value(forKey: "cell") as? String!)
            }
            else{
                Await.cell = ""
            }
            
            if (arr_await.object(at: i) as! NSDictionary).value(forKey: "count") as? String! != nil{
                Await.count = ((arr_await.object(at: i) as! NSDictionary).value(forKey: "count") as? String!)
            }
            else{
                Await.count = ""
            }
            
            if (arr_await.object(at: i) as! NSDictionary).value(forKey: "label") as? String! != nil
            {
                Await.label = ((arr_await.object(at: i) as! NSDictionary).value(forKey: "label") as? String!)
            }
            else
            {
                Await.label = ""
            }
            
            if (arr_await.object(at: i) as! NSDictionary).value(forKey: "message") as? String! != nil
            {
                Await.message = ((arr_await.object(at: i) as! NSDictionary).value(forKey: "message") as? String!)
            }
            else
            {
                Await.message = ""
            }
            
            if (arr_await.object(at: i) as! NSDictionary).value(forKey: "primary") as? String! != nil
            {
                Await.primary = ((arr_await.object(at: i) as! NSDictionary).value(forKey: "primary") as? String!)
            }
            else
            {
                Await.primary = ""
            }
            
            if (arr_await.object(at: i) as! NSDictionary).value(forKey: "verified") as? String! != nil
            {
                Await.verified = ((arr_await.object(at: i) as! NSDictionary).value(forKey: "verified") as? String!)
            }
            else
            {
                Await.verified = ""
            }
            
            if (arr_await.object(at: i) as! NSDictionary).value(forKey: "sent") as? String! != nil
            {
                Await.sent = ((arr_await.object(at: i) as! NSDictionary).value(forKey: "sent") as? String!)
            }
            else
            {
                Await.sent = ""
            }
        }
        do {
            managedContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
            try appDelegate.persistentContainer.viewContext.save()
            
        }
        catch {
            fatalError("Failure to save context: \(error)")
        }
    }
    
    
    // MARK: - Save chat List
    func saveInboxList(arr_inbox:NSMutableArray, isUpdate: Bool) {
        //1
        
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity =  NSEntityDescription.entity(forEntityName: "Inbox",
                                                 in:
            managedContext)
        for i in 0..<arr_inbox.count
        {
            let Inbox = NSManagedObject(entity: entity!,
                                        insertInto:managedContext) as! Inbox
            
            if (arr_inbox.object(at: i) as! NSDictionary).value(forKey: "account") as? String! != nil{
                Inbox.account = ((arr_inbox.object(at: i) as! NSDictionary).value(forKey: "account") as? String!)
            }
            else{
                Inbox.account = ""
            }
            
            if (arr_inbox.object(at: i) as! NSDictionary).value(forKey: "account_number") as? String! != nil
            {
                Inbox.account_number = ((arr_inbox.object(at: i) as! NSDictionary).value(forKey: "account_number") as? String!)
            }
            else{
                Inbox.account_number = ""
            }
            
            if (arr_inbox.object(at: i) as! NSDictionary).value(forKey: "cell") as? String! != nil{
                Inbox.cell = ((arr_inbox.object(at: i) as! NSDictionary).value(forKey: "cell") as? String!)
            }
            else{
                Inbox.cell = ""
            }
            
            if (arr_inbox.object(at: i) as! NSDictionary).value(forKey: "h") as? String! != nil
            {
                Inbox.h = ((arr_inbox.object(at: i) as! NSDictionary).value(forKey: "h") as? String!)
            }
            else
            {
                Inbox.h = ""
            }
            
            if (arr_inbox.object(at: i) as! NSDictionary).value(forKey: "label") as? String! != nil
            {
                Inbox.label = ((arr_inbox.object(at: i) as! NSDictionary).value(forKey: "label") as? String!)
            }
            else
            {
                Inbox.label = ""
            }
            
            if (arr_inbox.object(at: i) as! NSDictionary).value(forKey: "marketed") as? String! != nil
            {
                Inbox.marketed = ((arr_inbox.object(at: i) as! NSDictionary).value(forKey: "marketed") as? String!)
            }
            else
            {
                Inbox.marketed = ""
            }
            
            if (arr_inbox.object(at: i) as! NSDictionary).value(forKey: "rank") as? String! != nil
            {
                Inbox.rank = ((arr_inbox.object(at: i) as! NSDictionary).value(forKey: "rank") as? String!)
            }
            else
            {
                Inbox.rank = ""
            }
            
            if (arr_inbox.object(at: i) as! NSDictionary).value(forKey: "updated") as? String! != nil
            {
                
                print(((arr_inbox.object(at: i) as! NSDictionary).value(forKey: "updated") as? String!)!)
                
                Inbox.update = ((arr_inbox.object(at: i) as! NSDictionary).value(forKey: "updated") as? String!)!
            }
            else
            {
                Inbox.update = ""
            }
            
            if (arr_inbox.object(at: i) as! NSDictionary).value(forKey: "message") as? String! != nil
            {
                
                print(((arr_inbox.object(at: i) as! NSDictionary).value(forKey: "message") as? String!)!)
                
                Inbox.message = ((arr_inbox.object(at: i) as! NSDictionary).value(forKey: "message") as? String!)!
            }
            else
            {
                Inbox.message = ""
            }
            
            
            if (arr_inbox.object(at: i) as! NSDictionary).value(forKey: "visible") as? String! != nil
            {
                Inbox.visible = ((arr_inbox.object(at: i) as! NSDictionary).value(forKey: "visible") as? String!)
            }
            else
            {
                Inbox.visible = ""
            }
            
            if (arr_inbox.object(at: i) as! NSDictionary).value(forKey: "w") as? String! != nil
            {
                Inbox.w = ((arr_inbox.object(at: i) as! NSDictionary).value(forKey: "w") as? String!)
            }
            else
            {
                Inbox.w = ""
            }
            
            if (arr_inbox.object(at: i) as! NSDictionary).value(forKey: "window") as? String! != nil
            {
                Inbox.window = ((arr_inbox.object(at: i) as! NSDictionary).value(forKey: "window") as? String!)!
            }
            else
            {
                Inbox.window = ""
            }
            
            if (arr_inbox.object(at: i) as! NSDictionary).value(forKey: "x") as? String! != nil
            {
                Inbox.x = ((arr_inbox.object(at: i) as! NSDictionary).value(forKey: "x") as? String!)
            }
            else
            {
                Inbox.x = ""
            }
            
            if (arr_inbox.object(at: i) as! NSDictionary).value(forKey: "y") as? String! != nil
            {
                Inbox.y = ((arr_inbox.object(at: i) as! NSDictionary).value(forKey: "y") as? String!)
            }
            else
            {
                Inbox.y = ""
            }
        }
        
        do {
            managedContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
            try appDelegate.persistentContainer.viewContext.save()
            
        }
        catch {
            fatalError("Failure to save context: \(error)")
        }
        
        
        //5
        // Save data in managed object context.
        
        
        //self.saveLocationsForUserInDb(data.valueForKey("Location_List") as! NSArray, userProfile: userProfile)
    }
    
    func saveChat(arr_chat:NSMutableArray, isUpdate: Bool) {
        //1
        
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity =  NSEntityDescription.entity(forEntityName: "Chat",
                                                 in:
            managedContext)
        for i in 0..<arr_chat.count
        {
            let chat = NSManagedObject(entity: entity!,
                                        insertInto:managedContext) as! Chat
            
            if (arr_chat.object(at: i) as! NSDictionary).value(forKey: "c") as? String! != nil{
                chat.c = ((arr_chat.object(at: i) as! NSDictionary).value(forKey: "c") as? String!)
            }
            else{
                chat.c = ""
            }
            
            if (arr_chat.object(at: i) as! NSDictionary).value(forKey: "direction") as? String! != nil
            {
                chat.direction = ((arr_chat.object(at: i) as! NSDictionary).value(forKey: "direction") as? String!)
            }
            else{
                chat.direction = ""
            }
            
            if (arr_chat.object(at: i) as! NSDictionary).value(forKey: "id") as? String! != nil{
                chat.id = ((arr_chat.object(at: i) as! NSDictionary).value(forKey: "id") as? String!)
            }
            else{
                chat.id = ""
            }
            
            if (arr_chat.object(at: i) as! NSDictionary).value(forKey: "k") as? String! != nil{
                chat.k = ((arr_chat.object(at: i) as! NSDictionary).value(forKey: "k") as? String!)
            }
            else{
                chat.k = ""
            }
            
            if (arr_chat.object(at: i) as! NSDictionary).value(forKey: "m") as? String! != nil{
                chat.m = ((arr_chat.object(at: i) as! NSDictionary).value(forKey: "m") as? String!)
            }
            else{
                chat.m = ""
            }
            
            if (arr_chat.object(at: i) as! NSDictionary).value(forKey: "message") as? String! != nil{
                chat.message = ((arr_chat.object(at: i) as! NSDictionary).value(forKey: "message") as? String!)
            }
            else{
                chat.message = ""
            }
            
            if (arr_chat.object(at: i) as! NSDictionary).value(forKey: "p") as? String! != nil{
                chat.p = ((arr_chat.object(at: i) as! NSDictionary).value(forKey: "p") as? String!)
            }
            else{
                chat.p = ""
            }
            
            if (arr_chat.object(at: i) as! NSDictionary).value(forKey: "r") as? String! != nil{
                chat.r = ((arr_chat.object(at: i) as! NSDictionary).value(forKey: "r") as? String!)
            }
            else{
                chat.r = ""
            }
            
            if (arr_chat.object(at: i) as! NSDictionary).value(forKey: "sender") as? String! != nil{
                chat.sender = ((arr_chat.object(at: i) as! NSDictionary).value(forKey: "sender") as? String!)
            }
            else{
                chat.sender = ""
            }
            
            if (arr_chat.object(at: i) as! NSDictionary).value(forKey: "sent") as? String! != nil{
                chat.sent = ((arr_chat.object(at: i) as! NSDictionary).value(forKey: "sent") as? String!)
            }
            else{
                chat.sent = ""
            }
            
            if (arr_chat.object(at: i) as! NSDictionary).value(forKey: "utc") as? String! != nil{
                chat.utc = ((arr_chat.object(at: i) as! NSDictionary).value(forKey: "utc") as? String!)
            }
            else{
                chat.utc = ""
            }
            
            if (arr_chat.object(at: i) as! NSDictionary).value(forKey: "v") as? String! != nil{
                chat.v  = ((arr_chat.object(at: i) as! NSDictionary).value(forKey: "v") as? String!)
            }
            else{
                chat.v = ""
            }
            
            if (arr_chat.object(at: i) as! NSDictionary).value(forKey: "cell") as? String! != nil{
                chat.cell  = ((arr_chat.object(at: i) as! NSDictionary).value(forKey: "cell") as? String!)
            }
            else{
                chat.cell = ""
            }
        }
        
        do {
            managedContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
            try appDelegate.persistentContainer.viewContext.save()
            
        }
        catch {
            fatalError("Failure to save context: \(error)")
        }
        
        
        //5
        // Save data in managed object context.
        
        
        //self.saveLocationsForUserInDb(data.valueForKey("Location_List") as! NSArray, userProfile: userProfile)
    }

    
    func saveTemplatesDb(arr_Template:NSMutableArray, isUpdate: Bool) {
        //1
        
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        
        
        //        if self.fetchUserProfileFromDB(String(describing: UserDefaults.standard.value(forKey: loggedInUserId)!)).count == 0 {
        //2
        
        //        }
        //        else {
        //            contact = self.fetchUserProfileFromDB(String(describing: UserDefaults.standard.value(forKey: loggedInUserId)!))[0] as! Contact
        //        }
        let entity =  NSEntityDescription.entity(forEntityName: "Template",
                                                 in:
            managedContext)
        for i in 0..<arr_Template.count
        {
            let template = NSManagedObject(entity: entity!,
                                          insertInto:managedContext) as! Template
            
            if (arr_Template.object(at: i) as! NSDictionary).value(forKey: "id") as? String! != nil{
                template.id = ((arr_Template.object(at: i) as! NSDictionary).value(forKey: "id") as? String!)
            }
            else{
                template.id = ""
            }
            
            if (arr_Template.object(at: i) as! NSDictionary).value(forKey: "label") as? String! != nil
            {
                template.label = ((arr_Template.object(at: i) as! NSDictionary).value(forKey: "label") as? String!)
            }
            else{
                template.label = ""
            }
            
            if (((arr_Template.object(at: i) as! NSDictionary).value(forKey: "tags") as? NSArray)?.count)! > 0
            {
                template.tags = (arr_Template.object(at: i) as! NSDictionary).value(forKey: "tags") as? NSArray
            }
            else{
                template.tags = []  as Array as NSObject?
            }
            
            if (arr_Template.object(at: i) as! NSDictionary).value(forKey: "owned") as? String! != nil
            {
                template.owned = ((arr_Template.object(at: i) as! NSDictionary).value(forKey: "owned") as? String!)
            }
            else{
                template.owned = ""
            }
        }
        do {
            managedContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
            try appDelegate.persistentContainer.viewContext.save()
        }
        catch {
            fatalError("Failure to save context: \(error)")
        }
        
        
        //5
        // Save data in managed object context.
        
        
        //self.saveLocationsForUserInDb(data.valueForKey("Location_List") as! NSArray, userProfile: userProfile)
    }
    
    
    
//    func saveUserImageInDb (_ data:NSDictionary, isUpdate: Bool) {
//        //1
//        let appDelegate =
//            UIApplication.shared.delegate as! AppDelegate
//        
//        let managedContext = appDelegate.persistentContainer.viewContext
//        
//        var userProfile:User!
//        
//        
//        
//        if self.fetchUserProfileFromDB(String(describing: UserDefaults.standard.value(forKey: loggedInUserIdKey)!)).count == 0 {
//            //2
//            let entity =  NSEntityDescription.entity(forEntityName: "User",
//                                                            in:
//                managedContext)
//            userProfile = NSManagedObject(entity: entity!,
//                                          insertInto:managedContext) as! User
//        }
//        else {
//            userProfile = self.fetchUserProfileFromDB(String(describing: UserDefaults.standard.value(forKey: loggedInUserIdKey)!))[0] as! User
//        }
//        
//        //4
//        if let userId: String = data.value(forKey: "customer_id") as? String {
//            userProfile.customer_id = userId
//        }
//        
//        if let userimage: String = data.value(forKey: "image") as? String {
//            userProfile.image = userimage
//        }
//        
//        //5
//        // Save data in managed object context.
//        do {
//            try appDelegate.persistentContainer.viewContext.save()
//        }
//        catch {
//            fatalError("Failure to save context: \(error)")
//        }
//        
//        //self.saveLocationsForUserInDb(data.valueForKey("Location_List") as! NSArray, userProfile: userProfile)
//    }
//    
    
    //MARK: - Delete records in Table From DB
    func deleteContactFromDB(_ dbArray:Array<NSManagedObject>) {
        //1 - Fetch App delegate instance and managed context
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //2 - Fetch data from DB
        var arrDataFromDB = dbArray
        
        if arrDataFromDB.count > 0 {
            //3 - Loop through all rows of data and delete object.
            for rowNo in 0...arrDataFromDB.count - 1 {
                managedContext.delete(arrDataFromDB[rowNo] as NSManagedObject)
            }
            
            // Save data in managed object context.
            do {
                try appDelegate.persistentContainer.viewContext.save()
            }
            catch {
                fatalError("Failure to save context: \(error)")
            }
        }
    }
    
    
    // MARK: - Fetch Results from database
    
    func fetchProfileData(cell:String) -> Array<NSManagedObject> {
        //1 - Fetch App delegate instance and managed context
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //2 - Create fetch Request with entity - User
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Profile")
        // let fetchRequest = NSFetchRequest(entityName:"User")
        
        if cell != "" {
            let predicate = NSPredicate(format: "cell = %@", "\(cell)")
            fetchRequest.predicate = predicate
        }
        
        let latestRecordSortDescriptor = NSSortDescriptor(key: "label", ascending: false, selector: #selector(NSString.localizedStandardCompare(_:)))
        fetchRequest.sortDescriptors = [latestRecordSortDescriptor]
        
        //3 - Execute fetch request to receive array from DB
        do {
            let fetchedResults = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            
            
            return fetchedResults
        }
        catch let error as NSError {
            CommonFunctions.sharedCommonFunctions.CustomLog ("Fetch failed:\(error.localizedDescription)")
            return []
        }
    }

    
    
    
    func fetchContactfromDB() -> Array<NSManagedObject> {
        //1 - Fetch App delegate instance and managed context
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //2 - Create fetch Request with entity - User
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Contact")
       // let fetchRequest = NSFetchRequest(entityName:"User")
        
//        if user_id != "" {
//            let predicate = NSPredicate(format: "id = %@", "\(user_id)")
//            fetchRequest.predicate = predicate
//        }
//        
        let latestRecordSortDescriptor = NSSortDescriptor(key: "label", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
        fetchRequest.sortDescriptors = [latestRecordSortDescriptor]
        
        //3 - Execute fetch request to receive array from DB
        do {
            let fetchedResults = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
         
            
            return fetchedResults
        }
        catch let error as NSError {
            CommonFunctions.sharedCommonFunctions.CustomLog ("Fetch failed:\(error.localizedDescription)")
            return []
        }
    }
    
    
    func fetchRecentfromDB() -> Array<NSManagedObject> {
        //1 - Fetch App delegate instance and managed context
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //2 - Create fetch Request with entity - User
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Recent")
        // let fetchRequest = NSFetchRequest(entityName:"User")
        
        //        if user_id != "" {
        //            let predicate = NSPredicate(format: "id = %@", "\(user_id)")
        //            fetchRequest.predicate = predicate
        //        }
        //
        let latestRecordSortDescriptor = NSSortDescriptor(key: "label", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
        fetchRequest.sortDescriptors = [latestRecordSortDescriptor]
        
        //3 - Execute fetch request to receive array from DB
        do {
            let fetchedResults = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            
            
            return fetchedResults
        }
        catch let error as NSError {
            CommonFunctions.sharedCommonFunctions.CustomLog ("Fetch failed:\(error.localizedDescription)")
            return []
        }
    }
    
    func fetchInboxfromDB() -> Array<NSManagedObject> {
        //1 - Fetch App delegate instance and managed context
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //2 - Create fetch Request with entity - User
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Inbox")
        // let fetchRequest = NSFetchRequest(entityName:"User")
        
        //        if user_id != "" {
        //            let predicate = NSPredicate(format: "id = %@", "\(user_id)")
        //            fetchRequest.predicate = predicate
        //        }
        //
        let latestRecordSortDescriptor = NSSortDescriptor(key: "cell", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
        fetchRequest.sortDescriptors = [latestRecordSortDescriptor]
        
        //3 - Execute fetch request to receive array from DB
        do {
            let fetchedResults = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            
            
            return fetchedResults
        }
        catch let error as NSError {
            CommonFunctions.sharedCommonFunctions.CustomLog ("Fetch failed:\(error.localizedDescription)")
            return []
        }
    }
    
    func fetchAwaitList() -> Array<NSManagedObject> {
        //1 - Fetch App delegate instance and managed context
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //2 - Create fetch Request with entity - User
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Await")
        // let fetchRequest = NSFetchRequest(entityName:"User")
        
        //        if user_id != "" {
        //            let predicate = NSPredicate(format: "id = %@", "\(user_id)")
        //            fetchRequest.predicate = predicate
        //        }
        //
        let latestRecordSortDescriptor = NSSortDescriptor(key: "cell", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
        fetchRequest.sortDescriptors = [latestRecordSortDescriptor]
        
        //3 - Execute fetch request to receive array from DB
        do {
            let fetchedResults = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            
            
            return fetchedResults
        }
        catch let error as NSError {
            CommonFunctions.sharedCommonFunctions.CustomLog ("Fetch failed:\(error.localizedDescription)")
            return []
        }
    }
    
    func fetchAccountsData() -> Array<NSManagedObject> {
        //1 - Fetch App delegate instance and managed context
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //2 - Create fetch Request with entity - User
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Accounts")
        // let fetchRequest = NSFetchRequest(entityName:"User")
        
        //        if user_id != "" {
        //            let predicate = NSPredicate(format: "id = %@", "\(user_id)")
        //            fetchRequest.predicate = predicate
        //        }
        //
        let latestRecordSortDescriptor = NSSortDescriptor(key: "label", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
        fetchRequest.sortDescriptors = [latestRecordSortDescriptor]
        
        //3 - Execute fetch request to receive array from DB
        do {
            let fetchedResults = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            
            
            return fetchedResults
        }
        catch let error as NSError {
            CommonFunctions.sharedCommonFunctions.CustomLog ("Fetch failed:\(error.localizedDescription)")
            return []
        }
    }

    
    func fetchChatList(cell:String) -> Array<NSManagedObject> {
        //1 - Fetch App delegate instance and managed context
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //2 - Create fetch Request with entity - User
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Chat")
        // let fetchRequest = NSFetchRequest(entityName:"User")
        
                if cell != "" {
                    let predicate = NSPredicate(format: "cell = %@", "\(cell)")
                    fetchRequest.predicate = predicate
                }
        
        let latestRecordSortDescriptor = NSSortDescriptor(key: "id", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
        fetchRequest.sortDescriptors = [latestRecordSortDescriptor]
        
        //3 - Execute fetch request to receive array from DB
        do {
            let fetchedResults = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            
            
            return fetchedResults
        }
        catch let error as NSError {
            CommonFunctions.sharedCommonFunctions.CustomLog ("Fetch failed:\(error.localizedDescription)")
            return []
        }
    }

    
    func fetchTemplatefromDB() -> Array<NSManagedObject> {
        //1 - Fetch App delegate instance and managed context
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //2 - Create fetch Request with entity - User
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Template")
        // let fetchRequest = NSFetchRequest(entityName:"User")
        
        //        if user_id != "" {
        //            let predicate = NSPredicate(format: "id = %@", "\(user_id)")
        //            fetchRequest.predicate = predicate
        //        }
        //
        let latestRecordSortDescriptor = NSSortDescriptor(key: "id", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
        fetchRequest.sortDescriptors = [latestRecordSortDescriptor]
        
        //3 - Execute fetch request to receive array from DB
        do {
            let fetchedResults = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            
            
            return fetchedResults
        }
        catch let error as NSError {
            CommonFunctions.sharedCommonFunctions.CustomLog ("Fetch failed:\(error.localizedDescription)")
            return []
        }
    }
    
    
}



//
//  Profile+CoreDataProperties.swift
//  TextMaxx Pro
//
//  Created by surender on 19/01/17.
//  Copyright © 2017 Trigma. All rights reserved.
//

import Foundation
import CoreData


extension Profile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Profile> {
        return NSFetchRequest<Profile>(entityName: "Profile");
    }

    @NSManaged public var accepted_account: String?
    @NSManaged public var accepted_market: String?
    @NSManaged public var accepts_account: String?
    @NSManaged public var accepts_market: String?
    @NSManaged public var account_number: String?
    @NSManaged public var account_on_file: String?
    @NSManaged public var awaiting: String?
    @NSManaged public var carrier: String?
    @NSManaged public var dob: String?
    @NSManaged public var employees: String?
    @NSManaged public var error: String?
    @NSManaged public var ivr: String?
    @NSManaged public var label: String?
    @NSManaged public var language: String?
    @NSManaged public var marketed_when: String?
    @NSManaged public var pending_account_opt_in: String?
    @NSManaged public var pending_market_opt_in: String?
    @NSManaged public var received: String?
    @NSManaged public var recently_marketed: String?
    @NSManaged public var sent: String?
    @NSManaged public var stopped: String?
    @NSManaged public var tags: String?
    @NSManaged public var variables: NSObject?
    @NSManaged public var web: String?
     @NSManaged public var cell: String?

}

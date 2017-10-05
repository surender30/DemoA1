//
//  Inbox+CoreDataProperties.swift
//  TextMaxx Pro
//
//  Created by surender on 22/03/17.
//  Copyright © 2017 Trigma. All rights reserved.
//

import Foundation
import CoreData


extension Inbox {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Inbox> {
        return NSFetchRequest<Inbox>(entityName: "Inbox");
    }

    @NSManaged public var account: String?
    @NSManaged public var account_number: String?
    @NSManaged public var cell: String?
    @NSManaged public var h: String?
    @NSManaged public var label: String?
    @NSManaged public var marketed: String?
    @NSManaged public var rank: String?
    @NSManaged public var update: String?
    @NSManaged public var visible: String?
    @NSManaged public var message: String?
    @NSManaged public var w: String?
    @NSManaged public var window: String?
    @NSManaged public var x: String?
    @NSManaged public var y: String?

}

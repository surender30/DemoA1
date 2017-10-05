//
//  Chat+CoreDataProperties.swift
//  TextMaxx Pro
//
//  Created by Surender on 10/01/17.
//  Copyright © 2017 Trigma. All rights reserved.
//

import Foundation
import CoreData


extension Chat {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Chat> {
        return NSFetchRequest<Chat>(entityName: "Chat");
    }

    @NSManaged public var c: String?
    @NSManaged public var direction: String?
    @NSManaged public var id: String?
    @NSManaged public var k: String?
    @NSManaged public var m: String?
    @NSManaged public var message: String?
    @NSManaged public var p: String?
    @NSManaged public var r: String?
    @NSManaged public var sender: String?
    @NSManaged public var sent: String?
    @NSManaged public var utc: String?
    @NSManaged public var v: String?
    @NSManaged public var cell: String?

}

//
//  Await+CoreDataProperties.swift
//  TextMaxx Pro
//
//  Created by Surender on 01/01/17.
//  Copyright © 2017 Trigma. All rights reserved.
//

import Foundation
import CoreData


extension Await {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Await> {
        return NSFetchRequest<Await>(entityName: "Await");
    }

    @NSManaged public var accountNumber: String?
    @NSManaged public var cell: String?
    @NSManaged public var count: String?
    @NSManaged public var label: String?
    @NSManaged public var message: String?
    @NSManaged public var primary: String?
    @NSManaged public var sent: String?
    @NSManaged public var verified: String?

}

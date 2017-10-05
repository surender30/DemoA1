//
//  Contact+CoreDataProperties.swift
//  TextMaxx Pro
//
//  Created by Surender on 01/01/17.
//  Copyright © 2017 Trigma. All rights reserved.
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact");
    }

    @NSManaged public var accountNumber: String?
    @NSManaged public var cell: String?
    @NSManaged public var label: String?
    @NSManaged public var verified: String?

}

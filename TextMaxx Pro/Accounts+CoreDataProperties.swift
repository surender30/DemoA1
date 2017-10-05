//
//  Accounts+CoreDataProperties.swift
//  TextMaxx Pro
//
//  Created by surender on 19/01/17.
//  Copyright © 2017 Trigma. All rights reserved.
//

import Foundation
import CoreData


extension Accounts {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Accounts> {
        return NSFetchRequest<Accounts>(entityName: "Accounts");
    }

    @NSManaged public var customer: String?
    @NSManaged public var holder: String?
    @NSManaged public var issuer: String?
    @NSManaged public var label: String?
    @NSManaged public var last_four: String?
    @NSManaged public var token: String?
    @NSManaged public var type: String?

}

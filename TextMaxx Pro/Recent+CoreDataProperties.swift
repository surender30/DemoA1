//
//  Recent+CoreDataProperties.swift
//  TextMaxx Pro
//
//  Created by surender on 06/02/17.
//  Copyright © 2017 Trigma. All rights reserved.
//

import Foundation
import CoreData


extension Recent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recent> {
        return NSFetchRequest<Recent>(entityName: "Recent");
    }

    @NSManaged public var account_number: String?
    @NSManaged public var cell: String?
    @NSManaged public var label: String?

}

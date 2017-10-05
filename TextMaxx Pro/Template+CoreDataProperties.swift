//
//  Template+CoreDataProperties.swift
//  TextMaxx Pro
//
//  Created by Surender on 01/01/17.
//  Copyright © 2017 Trigma. All rights reserved.
//

import Foundation
import CoreData


extension Template {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Template> {
        return NSFetchRequest<Template>(entityName: "Template");
    }

    @NSManaged public var id: String?
    @NSManaged public var label: String?
    @NSManaged public var owned: String?
    @NSManaged public var tags: NSObject?

}

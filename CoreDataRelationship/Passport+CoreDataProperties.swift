//
//  Passport+CoreDataProperties.swift
//  CoreDataRelationship
//
//  Created by Tan Vinh Phan on 2/26/20.
//  Copyright © 2020 PTV. All rights reserved.
//
//

import Foundation
import CoreData


extension Passport {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Passport> {
        return NSFetchRequest<Passport>(entityName: "Passport")
    }

    @NSManaged public var number: String?
    @NSManaged public var expireDate: Date?
    @NSManaged public var ofUser: User?

}

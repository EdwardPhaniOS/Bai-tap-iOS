//
//  Task+CoreDataProperties.swift
//  CoreDataRelationship
//
//  Created by Tan Vinh Phan on 2/26/20.
//  Copyright © 2020 PTV. All rights reserved.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var taskDetail: String?
    @NSManaged public var status: Int16
    @NSManaged public var ofUser: User?

}

//
//  Student+CoreDataProperties.swift
//  AttendanceCoreData
//
//  Created by Asawari Kanitkar on 3/22/20.
//  Copyright © 2020 Asawari Kanitkar. All rights reserved.
//
//

import Foundation
import CoreData


extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var datesAttended: [Date]?
    @NSManaged public var name: String?
    @NSManaged public var payments: [Float]?

}

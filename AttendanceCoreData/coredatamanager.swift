//
//  coredatamanager.swift
//  AttendanceCoreData
//
//  Created by Asawari Kanitkar on 3/19/20.
//  Copyright © 2020 Asawari Kanitkar. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
    var students: [Student]?
    private let managedContext: NSManagedObjectContext?
    
    init() {
        managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Student>(entityName: "Student")
        students = try? managedContext?.fetch(fetchRequest)
    }
    
    func addStudent(name: String, cost: String) {
        guard let managedContext = managedContext, let studentEntity = NSEntityDescription.entity(forEntityName: "Student", in: managedContext) else {
            return print("could not save, no managed context")
        }
        let student = Student(entity: studentEntity, insertInto: managedContext)
        student.datesAttended = [Date]()
        student.payments = [Int]()
        student.name = name
        let cost:Int16 = Int16(cost) ?? 20
        student.classCost = cost
        students?.append(student)
        
        do {
            try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
    }
    
    func updatePayment(for student: Student, amount: Int) {
        guard let managedContext = managedContext else {
            return print("could not save, no managed context")
        }
        let existingPayments = student.payments ?? []
        var updatedPayments = existingPayments
        updatedPayments.append(amount)
        student.payments = updatedPayments
        do {
        try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

    func updateAttendance(for student: Student, date: Date) {
        guard let managedContext = managedContext else {
            return print("could not save, no managed context")
        }
        let existingDates = student.datesAttended ?? []
        var updatedDates = existingDates
        updatedDates.append(date)
        student.datesAttended = updatedDates
        do {
        try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

    func save() {
        try? managedContext?.save()
    }
    
}

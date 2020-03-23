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
    
    func addStudent(name: String) {
        guard let managedContext = managedContext, let studentEntity = NSEntityDescription.entity(forEntityName: "Student", in: managedContext) else {
            return print("could not save, no managed context")
        }
        let student = Student(entity: studentEntity, insertInto: managedContext)
        student.datesAttended = [Date]()
        student.payments = [Float]()
        student.name = name
        students?.append(student)
        
        do {
            try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
    }
    
    func updatePayment(for student: Student, amount: Float) {
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
    
    func save() {
        try? managedContext?.save()
    }
    
}

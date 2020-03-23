//
//  AttendanceViewController.swift
//  AttendanceCoreData
//
//  Created by Asawari Kanitkar on 3/8/20.
//  Copyright © 2020 Asawari Kanitkar. All rights reserved.
//

import UIKit
import CoreData

class AttendanceViewController: UIViewController {
    var students: [Student] = []
    @IBOutlet weak var attendanceTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCoreData()
        attendanceTableView.dataSource = self
        attendanceTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewDidLoad()
        attendanceTableView.reloadData()
    }
    
    func fetchCoreData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Student")
        do {
            students = try managedContext.fetch(fetchRequest) as! [Student]
//            for student in students {
//                let mPayments = student.value(forKey: "payments") as! [Float]
//            }
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let attendanceDetailVC = segue.destination as? AttendanceDetailViewController, let index = attendanceTableView.indexPathForSelectedRow?.row else {
            return
        }
        attendanceDetailVC.student = students[index]
    }
    
    func saveAttendance(for student: NSObject) {
        if var datesAttended = student.value(forKey: "datesAttended") as? [Date] {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                datesAttended.append(Date())
                student.setValue(datesAttended, forKey: "datesAttended")
                let managedContext = appDelegate.persistentContainer.viewContext
                do {
                    try managedContext.save()
                } catch let error as NSError {
                  print("Could not save today's attendance. \(error), \(error.userInfo)")
                }
            }
        }
    }
}

extension AttendanceViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let student = students[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell", for: indexPath)
        if let cell = cell as? StudentCell {
            let name = student.value(forKey: "name") as? String
            cell.name.text = name
        }
        return cell
    }
    
     func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextItem = UIContextualAction(style: .normal, title: "Mark As Present") {  (action, view, completionHandler) in
            let student = self.students[indexPath.row]
            print(student)
            self.saveAttendance(for: student)
            completionHandler(true)
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])

        return swipeActions
    }
    
    
}

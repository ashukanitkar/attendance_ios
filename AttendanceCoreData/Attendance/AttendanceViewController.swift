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
    var students: [NSManagedObject] = []
    @IBOutlet weak var attendanceTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCoreData()
        attendanceTableView.dataSource = self
        attendanceTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewDidLoad()
    }
    
    func fetchCoreData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Student")
        do {
          students = try managedContext.fetch(fetchRequest)
            for student in students {
                let mPayments = student.value(forKey: "payments") as! Payments
            }
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
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
    
    
}

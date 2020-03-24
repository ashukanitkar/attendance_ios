//
//  AttendanceDetailViewController.swift
//  AttendanceCoreData
//
//  Created by Asawari Kanitkar on 3/10/20.
//  Copyright © 2020 Asawari Kanitkar. All rights reserved.
//

import UIKit
import CoreData

class AttendanceDetailViewController: UIViewController {
    var student: Student?
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var attendanceHistoryTable: UITableView!
    @IBAction func saveButtonTapped(_ sender: Any) {
        let date:Date = datePicker.date
        saveDateToCoreData(date: date)
        attendanceHistoryTable.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = student?.name
        datePicker.maximumDate = Date()
        attendanceHistoryTable.delegate = self
        attendanceHistoryTable.dataSource = self
    }
    
    func saveDateToCoreData(date: Date) {
        if let student = student {
            CoreDataManager.shared.updateAttendance(for: student, date: date)
        }
    }
    
    func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let myString = formatter.string(from: date) // string purpose I add here
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = "MM-dd-yyyy"
        let myStringafd = formatter.string(from: yourDate!)
        return myStringafd
    }
}

extension AttendanceDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let dates = student?.value(forKey: "datesAttended") as? [Date] {
            return dates.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "attendanceHistoryCell", for: indexPath)
            if let student = student, let cell = cell as? AttendanceHistoryCell {
                let dates = student.datesAttended
                if let dates = dates {
                    cell.dateLabel.text = dateToString(date: dates[indexPath.row])
                }
            }
            return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Attendance History"
    }
}

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
        students = CoreDataManager.shared.students ?? []
        attendanceTableView.dataSource = self
        attendanceTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewDidLoad()
        attendanceTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let attendanceDetailVC = segue.destination as? AttendanceDetailViewController, let index = attendanceTableView.indexPathForSelectedRow?.row else {
            return
        }
        attendanceDetailVC.student = students[index]
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
            let name = student.name
            cell.name.text = name
        }
        return cell
    }
    
     func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextItem = UIContextualAction(style: .normal, title: "Mark As Present") {  (action, view, completionHandler) in
            let student = self.students[indexPath.row]
            CoreDataManager.shared.updateAttendance(for: student, date: Date())
            completionHandler(true)
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])

        return swipeActions
    }
    
    
}

//
//  PaymentsViewController.swift
//  AttendanceCoreData
//
//  Created by Asawari Kanitkar on 2/28/20.
//  Copyright © 2020 Asawari Kanitkar. All rights reserved.
//

import UIKit
import CoreData

class PaymentsViewController: UIViewController {
    @IBOutlet weak var studentTableView: UITableView!
    var students: [Student] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        studentTableView.delegate = self
        studentTableView.dataSource = self
        fetchCoreData()
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchCoreData()
        studentTableView.reloadData()
    }
    func fetchCoreData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Student")
        do {
            students = try managedContext.fetch(fetchRequest) as! [Student]
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let paymentDetailVC = segue.destination as? PaymentDetailsViewController, let index = studentTableView.indexPathForSelectedRow?.row else {
            return
        }
        paymentDetailVC.student = students[index]
    }

}

extension PaymentsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let student = students[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell", for: indexPath)
        if let cell = cell as? StudentCell {
            cell.name.text = student.value(forKey: "name") as? String
        }
        return cell
    }
}

//
//  ViewController.swift
//  AttendanceCoreData
//
//  Created by Asawari Kanitkar on 2/25/20.
//  Copyright © 2020 Asawari Kanitkar. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    var students: [NSManagedObject] = []
    @IBOutlet weak var studentTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        studentTableView.delegate = self
        studentTableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    @IBAction func addStudent(_ sender: Any) {
      let alert = UIAlertController(title: "New Student", message: "Add a new name", preferredStyle: .alert)
      let saveAction = UIAlertAction(title: "Save", style: .default) {
        [unowned self] action in
        guard let textField = alert.textFields?.first,
          let nameToSave = textField.text else {
            return
        }
        self.save(name: nameToSave)
        self.studentTableView.reloadData()
      }
      let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
      alert.addTextField()
      alert.addAction(saveAction)
      alert.addAction(cancelAction)
      present(alert, animated: true)
    }
    
    func save(name: String) {
      guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
        return
      }
      let managedContext = appDelegate.persistentContainer.viewContext
      let entity = NSEntityDescription.entity(forEntityName: "Student", in: managedContext)!
      let student = NSManagedObject(entity: entity, insertInto: managedContext)
      student.setValue(name, forKeyPath: "name")
      do {
        try managedContext.save()
        students.append(student)
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
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


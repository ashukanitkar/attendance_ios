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
    var students: [Student] = []
    @IBOutlet weak var studentTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 0.1764705882, blue: 0.3333333333, alpha: 1)]
        students = CoreDataManager.shared.students ?? []
        studentTableView.delegate = self
        studentTableView.dataSource = self
        tabBarController?.tabBar.tintColor = #colorLiteral(red: 1, green: 0.1764705882, blue: 0.3333333333, alpha: 1)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //fetchCoreData()
        viewDidLoad()
    }

    @IBAction func addStudent(_ sender: Any) {
      let alert = UIAlertController(title: "New Student", message: "Add a new name", preferredStyle: .alert)
      let saveAction = UIAlertAction(title: "Save", style: .default) {
        [unowned self] action in
        guard let textField = alert.textFields?.first,
          let nameToSave = textField.text else {
            return
        }
        CoreDataManager.shared.addStudent(name: nameToSave)
        self.students = CoreDataManager.shared.students ?? []
        self.studentTableView.reloadData()
      }
      let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
      alert.addTextField()
      alert.addAction(saveAction)
      alert.addAction(cancelAction)
      present(alert, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let studentDetailVC = segue.destination as? StudentInformationDetailViewController, let index = studentTableView.indexPathForSelectedRow?.row else {
            return
        }
        studentDetailVC.student = students[index]
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
            let name = student.value(forKey: "name") as? String
            cell.name.text = name
        }
        return cell
    }
    
}


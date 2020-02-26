//
//  ViewController.swift
//  AttendanceCoreData
//
//  Created by Asawari Kanitkar on 2/25/20.
//  Copyright © 2020 Asawari Kanitkar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var students: [String] = []
    @IBOutlet weak var studentTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        studentTableView.delegate = self
        studentTableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    @IBAction func addStudent(_ sender: Any) {
      let alert = UIAlertController(title: "New Name",
                                    message: "Add a new name",
                                    preferredStyle: .alert)
      
      let saveAction = UIAlertAction(title: "Save",
                                     style: .default) {
        [unowned self] action in
                                      
        guard let textField = alert.textFields?.first,
          let nameToSave = textField.text else {
            return
        }
        
        self.students.append(nameToSave)
        self.studentTableView.reloadData()
      }
      
      let cancelAction = UIAlertAction(title: "Cancel",
                                       style: .cancel)
      
      alert.addTextField()
      
      alert.addAction(saveAction)
      alert.addAction(cancelAction)
      
      present(alert, animated: true)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell", for: indexPath)
        return cell
    }
    
}


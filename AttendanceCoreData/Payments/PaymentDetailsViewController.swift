//
//  PaymentDetailsViewController.swift
//  AttendanceCoreData
//
//  Created by Asawari Kanitkar on 3/4/20.
//  Copyright © 2020 Asawari Kanitkar. All rights reserved.
//

import UIKit

class PaymentDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let payments = student?.value(forKey: "payments") as? [Float] {
            return payments.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "paymentHistoryCell", for: indexPath)
        if let student = student {
            if let cell = cell as? PaymentHistoryCell {
                let payments = student.value(forKey: "payments") as? [Float]
                if let payments = payments {
                    cell.paymentAmountLabel.text = String(payments[indexPath.row])
                }
            }
        }
        return cell
    }
    
    @IBAction func savePayment(_ sender: Any) {
        let paymentAmountText: String = paymentAmount.text!
        let paymentAmountFloat = Float(paymentAmountText)
         if let paymentAmountFloat = paymentAmountFloat, var payments = student?.value(forKey: "payments") as? [Float] {
            payments.append(paymentAmountFloat)
            savePaymentToCoreData(payments: payments)
        }
        paymentAmount.text = ""
        self.view.endEditing(true)
        paymentHistoryTable.reloadData()
    }
    
    func savePaymentToCoreData(payments: [Float]) {
        if let student = student {
            student.setValue(payments, forKey: "payments")
        }
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
          return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        do {
            try managedContext.save()
        } catch let error as NSError {
          print("Could not save payment. \(error), \(error.userInfo)")
        }
            
    }
    @IBOutlet weak var paymentAmount: UITextField!
    @IBOutlet weak var studentName: UILabel!
    @IBOutlet weak var paymentHistoryTable: UITableView!
    var student: NSObject?
    override func viewDidLoad() {
        super.viewDidLoad()
        paymentHistoryTable.delegate = self
        paymentHistoryTable.dataSource = self
        studentName.text = student?.value(forKey: "name") as? String

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        paymentHistoryTable.delegate = self
        paymentHistoryTable.dataSource = self
        studentName.text = student?.value(forKey: "name") as? String
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

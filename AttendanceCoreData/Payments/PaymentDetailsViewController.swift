//
//  PaymentDetailsViewController.swift
//  AttendanceCoreData
//
//  Created by Asawari Kanitkar on 3/4/20.
//  Copyright © 2020 Asawari Kanitkar. All rights reserved.
//

import UIKit

class PaymentDetailsViewController: UIViewController {
    @IBOutlet weak var paymentAmount: UITextField!
    @IBOutlet weak var paymentHistoryTable: UITableView!
    var student: Student?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        paymentHistoryTable.delegate = self
        paymentHistoryTable.dataSource = self
        navigationItem.title = student?.name
    }
       
    override func viewWillAppear(_ animated: Bool) {
       viewDidLoad()
       paymentHistoryTable.reloadData()
    }
    
    @IBAction func savePayment(_ sender: Any) {
        let paymentAmountText: String = paymentAmount.text!
        let paymentAmountFloat = Float(paymentAmountText)
         if let paymentAmountFloat = paymentAmountFloat, let student = student {
            CoreDataManager.shared.updatePayment(for: student, amount: paymentAmountFloat)
        }
        paymentAmount.text = ""
        self.view.endEditing(true)
        paymentHistoryTable.reloadData()
    }
}
extension PaymentDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let payments = student?.payments {
            return payments.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "paymentHistoryCell", for: indexPath)
        if let student = student, let cell = cell as? PaymentHistoryCell {
            let payments = student.payments
            if let payments = payments {
                let amount = String(payments[indexPath.row])
                cell.paymentAmountLabel.text = "$" + amount
            }
        }
        return cell
    }
}

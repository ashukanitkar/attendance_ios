//
//  PaymentDetailsViewController.swift
//  AttendanceCoreData
//
//  Created by Asawari Kanitkar on 3/4/20.
//  Copyright © 2020 Asawari Kanitkar. All rights reserved.
//

import UIKit

class PaymentDetailsViewController: UIViewController {
    @IBOutlet weak var paymentAmountPicker: UIPickerView!
    @IBOutlet weak var paymentHistoryTable: UITableView!
    var student: Student?
    let paymentAmounts: [Int] = [10, 15, 20, 25, 30, 35, 40]
    override func viewDidLoad() {
        super.viewDidLoad()
        paymentHistoryTable.delegate = self
        paymentHistoryTable.dataSource = self
        paymentAmountPicker.delegate = self
        paymentAmountPicker.dataSource = self
        navigationItem.title = student?.name
    }
       
    override func viewWillAppear(_ animated: Bool) {
       viewDidLoad()
       paymentHistoryTable.reloadData()
    }
    
    @IBAction func savePayment(_ sender: Any) {
        let paymentAmount: Int = paymentAmounts[paymentAmountPicker.selectedRow(inComponent: 0)]
         if let student = student {
            CoreDataManager.shared.updatePayment(for: student, amount: paymentAmount)
        }
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Payment History"
    }
}
extension PaymentDetailsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return paymentAmounts.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(paymentAmounts[row])
    }
    
    
}

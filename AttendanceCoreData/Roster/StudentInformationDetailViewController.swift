//
//  StudentInformationDetailViewController.swift
//  AttendanceCoreData
//
//  Created by Asawari Kanitkar on 3/23/20.
//  Copyright © 2020 Asawari Kanitkar. All rights reserved.
//

import UIKit
import Foundation

class StudentInformationDetailViewController: UIViewController {
    var student: Student?
    @IBOutlet weak var costPerClassLabel: UILabel!
    @IBOutlet weak var amountDueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = student?.name ?? ""
        costPerClassLabel.text = "Cost Per Class: $" + String(student?.classCost ?? 0)
        amountDueLabel.text = "Amount Due: $" + getAmountOwed()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewDidLoad()
    }
    
    func getAmountOwed() -> String {
        let totalClasses = student?.datesAttended?.count ?? 0
        let costPerClass = student?.classCost ?? Int16(25)
        let payments = student?.payments ?? []
        let totalAmountPaid = payments.reduce(0, +)
        let amountOwed = Int(totalClasses*Int(costPerClass)) - totalAmountPaid
        return String(amountOwed)
    }
}

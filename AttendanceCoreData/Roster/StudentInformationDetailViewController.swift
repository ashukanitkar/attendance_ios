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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = getAmountOwed()
    }

    func getAmountOwed() -> String {
        let totalClasses = student?.datesAttended?.count ?? 0
        let costPerClass = 25
        let payments = student?.payments ?? []
        let totalAmountPaid = payments.reduce(0, +)
        let amountOwed = Float(totalClasses*costPerClass) - totalAmountPaid
        return String(amountOwed)
    }
}

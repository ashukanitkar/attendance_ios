//
//  PaymentDetailsViewController.swift
//  AttendanceCoreData
//
//  Created by Asawari Kanitkar on 3/4/20.
//  Copyright © 2020 Asawari Kanitkar. All rights reserved.
//

import UIKit

class PaymentDetailsViewController: UIViewController {
    @IBOutlet weak var studentName: UILabel!
    var student: NSObject?
    override func viewDidLoad() {
        super.viewDidLoad()
        studentName.text = student?.value(forKey: "name") as? String

        // Do any additional setup after loading the view.
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

//
//  Payments.swift
//  AttendanceCoreData
//
//  Created by Asawari Kanitkar on 3/5/20.
//  Copyright © 2020 Asawari Kanitkar. All rights reserved.
//

import UIKit

public class Payments: NSObject, NSCoding {

    public var payments: [Float] = []
    
    init(payments: [Float]) {
        self.payments = payments
    }
    
    enum Key: String {
        case payments = "payments"
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(payments, forKey: Key.payments.rawValue)
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        let mPayments = aDecoder.decodeObject(forKey: Key.payments.rawValue) as! [Float]
        self.init(payments: mPayments)
    }
}

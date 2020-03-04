////
////  payment.swift
////  AttendanceCoreData
////
////  Created by Asawari Kanitkar on 2/27/20.
////  Copyright © 2020 Asawari Kanitkar. All rights reserved.
////
//
//import UIKit
//
//class Payments: NSObject, NSCoding {
//
//    public var payments: [Payment] = []
//
//    enum Key:String {
//        case payments = "payments"
//    }
//
//    init(payments: [Payment]) {
//        self.payments = payments
//    }
//
//    public func encode(with aCoder: NSCoder) {
//        aCoder.encode(payments, forKey: Key.payments.rawValue)
//    }
//
//    public required convenience init?(coder aDecoder: NSCoder) {
//        let mPayments = aDecoder.decodeObject(forKey: Key.payments.rawValue) as! [Payment]
//        self.init(payments: mPayments)
//    }
//}
//
//public class Payment: NSObject, NSCoding {
//    //public var date: String
//    public var amount: Float
//
//    enum Key:String {
//        //case date = "date"
//        case amount = "amount"
//    }
//
//    init(amount: Float) {
//        //self.date = date
//        self.amount = amount
//    }
//
//    public func encode(with aCoder: NSCoder) {
//        //aCoder.encode(date, forKey: Key.date.rawValue)
//        aCoder.encode(amount, forKey: Key.amount.rawValue)
//    }
//
//    public required convenience init?(coder aDecoder: NSCoder) {
//        //let mDate = coder.decodeObject(forKey: Key.date.rawValue)
//        let mAmount = aDecoder.decodeFloat(forKey: Key.amount.rawValue)
//        self.init(amount: Float(mAmount))
//    }
//}

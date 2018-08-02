//
//  DateUtil.swift
//  artemis
//
//  Created by VF Consulting on 8/1/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import Foundation

class DateHelper{
    required init() {}
    
    static func create() -> Self {
        return self.init()
    }
    
    func getDateNow() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd"
        let dateRegister = formatter.string(from: date)
        return dateRegister
    }
    
}

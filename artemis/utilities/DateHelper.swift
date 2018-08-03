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
    
    func getDateNowToPython() -> String {
        let dateFormatterServer = DateFormatter()
        dateFormatterServer.dateFormat = "yyyy-MM-dd"
        let date = dateFormatterServer.string(from: Date())
        return date
    }
    
    func getDateNowToJava() -> String {
        let dateFormatterServer = DateFormatter()
        dateFormatterServer.dateFormat = "dd/MM/yyyy"
        let date = dateFormatterServer.string(from: Date())
        return date
    }
    
}

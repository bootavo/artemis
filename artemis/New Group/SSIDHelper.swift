//
//  SSIDHelper.swift
//  artemis
//
//  Created by Gustavo Tufiño Fernandez on 7/12/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import SystemConfiguration.CaptiveNetwork

internal class SSIDHelper {
    class func fetchSSIDInfo() ->  String {
        var currentSSID = ""
        if let interfaces:CFArray = CNCopySupportedInterfaces() {
            for i in 0..<CFArrayGetCount(interfaces){
                let interfaceName: UnsafeRawPointer = CFArrayGetValueAtIndex(interfaces, i)
                let rec = unsafeBitCast(interfaceName, to: AnyObject.self)
                let unsafeInterfaceData = CNCopyCurrentNetworkInfo("\(rec)" as CFString)
                if unsafeInterfaceData != nil {
                    
                    let interfaceData = unsafeInterfaceData! as Dictionary!
                    currentSSID = ((interfaceData as? [String : AnyObject])?["SSID"])! as! String
                    
                }
            }
        }
        return currentSSID
    }
}

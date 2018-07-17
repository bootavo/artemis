//
//  DeviceHelper.swift
//  artemis
//
//  Created by VF Consulting on 7/17/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit

class DeviceHelper: UIView {
    
    func isIphoneX() -> Bool {
        
        var state:Bool = false
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                print("iPhone 5 or 5S or 5C")
            case 1334:
                print("iPhone 6/6S/7/8")
            case 1920, 2208:
                print("iPhone 6+/6S+/7+/8+")
            case 2436:
                print("iPhone X")
                state = true
            default:
                print("unknown")
            }
        }
        return state
    }
    
}

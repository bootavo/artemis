//
//  ScreenHelper.swift
//  artemis
//
//  Created by Gustavo Tufiño Fernandez on 7/5/18.
//  Copyright © 2018 PatDevelop. All rights reserved.
//

import Foundation
import UIKit

class ScreenHelper{
    required init() {}
    
    static func create() -> Self {
        return self.init()
    }
    
    func getDevice() -> String {
        var device:String = Constants.DEVICE_SMARTPHONE
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                device = Constants.DEVICE_SMARTPHONE
            case 1334:
                device = Constants.DEVICE_SMARTPHONE
            case 1920, 2208:
                device = Constants.DEVICE_SMARTPHONE
            case 2436:
                device = Constants.DEVICE_IPHONE_X
            default:
                device = Constants.DEVICE_IPAD
            }
        }
        return device
    }

}

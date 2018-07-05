//
//  Extensions.swift
//  youtube
//
//  Created by admin on 22/03/18.
//  Copyright © 2018 GAP GLOBAL SOLUTIONS S.A.C. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static func title() -> UIColor{
        return UIColor(red: 28/255, green: 28/255, blue: 27/255, alpha: 1)
    }
    
    static func titleList() -> UIColor{
        return UIColor(red: 97/255, green: 97/255, blue: 97/255, alpha: 1)
    }
    
    static func subTitleList() -> UIColor{
        return UIColor(red: 146/255, green: 146/255, blue: 146/255, alpha: 1)
    }
    
    static func primaryDarkColor() -> UIColor{
        return UIColor(red: 213/255, green: 53/255, blue: 71/255, alpha: 1)
    }
    
    static func primaryColor() -> UIColor{
        return UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
    }
    
    static func accentColor() -> UIColor{
        return UIColor(red: 68/255, green: 179/255, blue: 139/255, alpha: 1)
    }
    
    static func placeHolder() -> UIColor{
        return UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1)
    }
    
}

extension UIView{
    func setAnchor(width: CGFloat, height: CGFloat){
        self.setAnchor(
            top: nil,
            left: nil,
            bottom: nil,
            right: nil,
            paddingTop: 0,
            paddingLeft: 0,
            paddingBottom: 0,
            paddingRight: 0,
            width: width,
            height: height)
    }
    
    func setAnchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?,
                   bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?,
                   paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat,
                   paddingRight: CGFloat = 0, width: CGFloat = 0, height: CGFloat = 0){
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: paddingRight).isActive = true
        }
        
        if width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        var safeTopAncho: NSLayoutYAxisAnchor{
            if #available(iOS 11.0, *){
                return safeAreaLayoutGuide.topAnchor
            }
            return topAnchor
        }
        
        var safeLeftAnchor: NSLayoutXAxisAnchor{
            if #available(iOS 11.0, *){
                return safeAreaLayoutGuide.leftAnchor
            }
            return leftAnchor
        }
        
        var safeBottomAcnhor: NSLayoutYAxisAnchor{
            if #available(iOS 11.0, *){
                return safeAreaLayoutGuide.bottomAnchor
            }
            return bottomAnchor
        }
        
        var safeRightAnchor: NSLayoutXAxisAnchor{
            if #available(iOS 11.0, *){
                return safeAreaLayoutGuide.rightAnchor
            }
            return rightAnchor
        }
        
    }
}

//
//  CustomTextField.swift
//  artemis
//
//  Created by Gustavo Tufiño Fernandez on 7/8/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit

extension UITextField{
    
    public convenience init(placeholder: String){
        self.init()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.borderStyle = .none
        self.layer.cornerRadius = 10
        self.backgroundColor = UIColor.primaryColor()
        self.textColor = UIColor.title()
        self.font = UIFont.systemFont(ofSize: 20)
        self.autocorrectionType = .no
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.placeHolder().cgColor
        self.layer.borderWidth = 1.0
        self.autocapitalizationType = .none
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = UITextFieldViewMode.always
        
        var placeHolder = NSMutableAttributedString()
        placeHolder = NSMutableAttributedString(attributedString: NSAttributedString(string: placeholder, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.placeHolder() ]))
        self.attributedPlaceholder = placeHolder
        self.setAnchor(width: 0, height: 40)
        self.textAlignment = .left
    }
    
}

extension UITextView{
    
    public convenience init(placeholder: String){
        self.init()
        self.translatesAutoresizingMaskIntoConstraints = false
//        self.borderStyle = .none
        self.layer.cornerRadius = 10
        self.backgroundColor = UIColor.primaryColor()
        self.textColor = UIColor.title()
        self.font = UIFont.systemFont(ofSize: 16)
        self.autocorrectionType = .no
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.placeHolder().cgColor
        self.layer.borderWidth = 1.0
        self.autocapitalizationType = .none
        
        self.contentInset = UIEdgeInsetsMake(5, 5, 5, 5)
        
        self.setAnchor(width: 0, height: 100)
        self.textAlignment = .left
    }
    
    func centerVertically() {
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        contentOffset.y = -positiveTopOffset
    }
    
}

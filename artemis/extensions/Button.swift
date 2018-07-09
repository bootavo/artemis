//
//  Button.swift
//  artemis
//
//  Created by Gustavo Tufiño Fernandez on 7/8/18.
//  Copyright © GTUFINOF. All rights reserved.
//

import UIKit

extension UIButton{
    func setTitle(title: String, color: UIColor){
        let title = NSMutableAttributedString(attributedString: NSAttributedString(string: title, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16), .foregroundColor: color ]))
        self.setAttributedTitle(title, for: .normal)
    }
}

class RoundedButton: UIButton{
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        let title = NSMutableAttributedString(attributedString: NSAttributedString(string: "INICIAR SESIÓN", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.primaryColor() ]))
        
        self.setAttributedTitle(title, for: .normal)
        self.backgroundColor = UIColor.primaryDarkColor()
        //button.setTitleColor(UIColor.primaryColor(), for: .normal)
        self.setAnchor(width: 0, height: 40)
        self.layer.cornerRadius = 0.5 * 40
        self.layer.borderColor = UIColor.primaryDarkColor().cgColor
        self.layer.borderWidth = 1
        self.alpha = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) RoundedButton has not been implemented")
    }
}

class RoundedSecondButton: UIButton{
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        let title = NSMutableAttributedString(attributedString: NSAttributedString(string: "CANCELAR", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.primaryDarkColor()]))
        
        self.setAttributedTitle(title, for: .normal)
        self.backgroundColor = UIColor.primaryColor()
        //button.setTitleColor(UIColor.primaryColor(), for: .normal)
        self.setAnchor(width: 0, height: 40)
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.primaryDarkColor().cgColor
        self.layer.borderWidth = 1
        self.alpha = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) RoundedSecondButton has not been implemented")
    }
}

class FooterButton: UIButton{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        let title = NSMutableAttributedString(attributedString: NSAttributedString(string: "Una app de VF Consulting", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.primaryColor() ]))
        
        self.setAttributedTitle(title, for: .normal)
        self.backgroundColor = UIColor.primaryDarkColor()
        //button.setTitleColor(UIColor.primaryColor(), for: .normal)
        self.layer.borderColor = UIColor.primaryDarkColor().cgColor
        self.layer.borderWidth = 1
        self.alpha = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) FooterButton has not been implemented")
    }
    
}

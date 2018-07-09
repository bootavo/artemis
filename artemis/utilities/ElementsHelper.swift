//
//  ElementsHelper.swift
//  artemis
//
//  Created by Gustavo Tufiño Fernandez on 7/6/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit

class ElementsHelper: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.masksToBounds = true
        backgroundColor = .clear
        titleLabel?.font =  UIFont.systemFont(ofSize: 14)
        translatesAutoresizingMaskIntoConstraints = false
        setTitleColor(.white, for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


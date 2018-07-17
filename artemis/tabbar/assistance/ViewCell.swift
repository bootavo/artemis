//
//  ViewCell.swift
//  artemis
//
//  Created by VF Consulting on 7/16/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews(){
        
    }
    
    required init?(coder aDecoder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
}


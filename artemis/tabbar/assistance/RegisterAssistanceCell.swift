//
//  RegisterCell.swift
//  artemis
//
//  Created by VF Consulting on 7/17/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit

class RegisterAssistanceCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("init()")
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let registerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    func setupView(){
        print("setupView()")
        backgroundColor = UIColor.black
        
        addSubview(registerCollectionView)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": registerCollectionView]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-50-[v0]-50-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": registerCollectionView]))
    }
    
}

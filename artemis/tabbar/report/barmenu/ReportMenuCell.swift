//
//  ReportMenuCell.swift
//  artemis
//
//  Created by VF Consulting on 8/3/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit

class ReportMenuCell: BaseCell {
    
    //ImageView que se repite en los CellViews del CollectionView
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "home")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
        return iv
    }()
    
    let title : UILabel = {
        let tv = UILabel()
        tv.text = "ASISTENCIA"
        tv.textColor = UIColor.title()
        tv.highlightedTextColor = UIColor.rgb(red: 91, green: 14, blue: 13)
        tv.backgroundColor = UIColor.white
        tv.font = UIFont.systemFont(ofSize: 12)
        return tv
    }()
    
    let lineView : UIView = {
        var lv = UIView(frame: CGRect(x: 0, y: 100, width: 320, height: 1.0))
        lv.layer.borderWidth = 0.5
        lv.layer.borderColor = UIColor.gray.cgColor
        return lv
    }()
    
    //Detectar el cambio de iconos
    override var isHighlighted: Bool {
        didSet {
            title.highlightedTextColor = isHighlighted ? UIColor.primaryDarkColor() : UIColor.rgb(red: 91, green: 14, blue: 13)
        }
    }
    
    //Cambiar de icono al seleccionarlos
    override var isSelected: Bool {
        didSet {
            title.highlightedTextColor = isSelected ? UIColor.primaryDarkColor() : UIColor.rgb(red: 91, green: 14, blue: 13)
        }
    }
    
    override func setupViews() {
        super.setupViews()
        //backgroundColor = UIColor.yellow
        
        //Agregando Subvies al CollectionView
        addSubview(title)
        addConstraintsWithFormat(format: "H:[v0(96)]", views: title)
        addConstraintsWithFormat(format: "V:[v0(28)]", views: title)
        
        //Agregando Restricciones a los items del CollecitonView
        
        //Restricciones Horizontales
        addConstraint(NSLayoutConstraint(item: title, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        
        //Restricciones Verticales
        addConstraint(NSLayoutConstraint(item: title, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        addSubview(lineView)
        lineView.snp.makeConstraints{
            (make) -> Void in
            make.width.equalToSuperview()
            make.bottom.equalTo(title.snp.bottom).offset(11)
            make.height.equalTo(0.5)
        }
        
        //Restricciones Horizontales
        //addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        
        //Restricciones Verticales
        //addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
    }
    
}


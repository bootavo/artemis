//
//  EmployeeCell.swift
//  artemis
//
//  Created by VF Consulting on 8/3/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import Foundation
import UIKit

class EmployeeCell: UICollectionViewCell{
    
    var item: Employee? {
        
        didSet {
            
            if let name = item?.vch_empleado {
                self.tv_name_employee.text = "\(name)"
            }
            
            if let cod = item?.vch_cod_empleado {
                self.tv_cod_employee.text = "\(cod)"
            }
            
            if let foto = item?.foto {
                getImageFromUrl(photo: foto)
            }else {
                self.iv_picture.imageView.image = UIImage(named: "ic_user_red")
            }
            
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has been not implemented")
    }
    
    let tv_name_employee: UITextView = {
        let text = UITextView()
        text.font = UIFont(name: "", size: 14)
        text.textColor = UIColor.black
        text.textAlignment = .left
        text.isUserInteractionEnabled = false
        return text
    }()
    
    let tv_cod_employee: UITextView = {
        let text = UITextView()
        text.font = UIFont(name: "", size: 14)
        text.textColor = UIColor.darkGray
        text.textAlignment = .left
        text.isUserInteractionEnabled = false
        return text
    }()
    
    let v_separator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        return view
    }()
    
    lazy var iv_picture: ProfileImageView = {
        let imgView = ProfileImageView()
        return imgView
    }()
    
    func getImageFromUrl(photo: String){
        let url = URL(string: photo)
        self.iv_picture.imageView.sd_setImage(with: url, completed: nil)
    }
    
    func setupViews(){
        backgroundColor = UIColor.clear
        
        addSubview(iv_picture)
        iv_picture.snp.makeConstraints { (make) -> Void in
            make.left.equalToSuperview().offset(15)
            make.width.equalTo(70)
            make.height.equalTo(70)
            make.centerY.equalToSuperview()
        }
        
        addSubview(tv_name_employee)
        tv_name_employee.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(20)
            make.left.equalTo(90)
            make.width.equalTo(300)
            make.height.equalTo(40)
        }
        
        addSubview(tv_cod_employee)
        tv_cod_employee.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(tv_name_employee).offset(20)
            make.left.equalToSuperview().offset(90)
            make.width.equalTo(300)
            make.height.equalTo(20)
        }
        
        addSubview(v_separator)
        v_separator.snp.makeConstraints { (make) -> Void in
            make.bottom.equalToSuperview()
            make.width.equalToSuperview().inset(16)
            make.height.equalTo(1)
            make.centerX.equalToSuperview()
        }
        
    }
    
}

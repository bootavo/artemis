//
//  ProjectViewCell.swift
//  artemis
//
//  Created by VF Consulting on 8/08/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import Foundation
import UIKit

class ProjectViewCell: UICollectionViewCell {
    
    var projectView: UIView? = nil
    
    var item: Project? {
        
        didSet {
            print("projectViewCell")
            print("\(item?.str_project_name) - \(item?.str_project_cod)")
            print("end projectViewCell")
            if let project_name = item?.str_project_name, let project_code = item?.str_project_cod {
                self.tv_project_name.text = "\(project_name) - \(project_code)"
            }
             
            if let start_date = item?.dte_initial_date, let end_date = item?.dte_end_date {
                self.tv_project_date.text = "\(start_date) - \(end_date)"
            }
            self.iv_picture.image = UIImage(named: "ic_project_red")
            
        }
        
    }
    
    func updateUI(view: UIView){
        print("updateUI")
        projectView = view
    }
    
    override var isSelected: Bool{
        didSet{
            if self.isSelected{
                showMessage(isSelected: true)
            }else{
                showMessage(isSelected: false)
            }
        }
    }
    
    func showMessage(isSelected: Bool) {
        if isSelected {
            projectView?.hideToast()
            projectView?.makeToast("\(item?.str_project_cod) - \(item?.str_project_name)")
            print("isSelected")
        }else{
            print("isNotSelected")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has been not implemented")
    }
    
    let tv_project_name: UITextView = {
        let text = UITextView()
        text.font = UIFont(name: "", size: 8)
        text.contentInset = UIEdgeInsetsMake(-7, 0, 0, 0)
        text.textColor = UIColor.darkGray
        text.textAlignment = .left
        text.isUserInteractionEnabled = false
        text.text = "ARTEMIS - ASD123"
        return text
    }()
    
    var tv_project_date: UITextView = {
        let text = UITextView()
        text.font = UIFont(name: "", size: 5)
        text.contentInset = UIEdgeInsetsMake(-7, 0, 0, 0)
        text.textColor = UIColor.gray
        text.textAlignment = .left
        text.isUserInteractionEnabled = false
        text.text = "03/08/2018 - 12/12/2018"
        return text
    }()
    
    lazy var iv_picture: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "ic_project_red")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let v_separator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        return view
    }()
    
    func setupViews(){
        backgroundColor = UIColor.clear
        
        addSubview(iv_picture)
        iv_picture.snp.makeConstraints { (make) -> Void in
            make.left.equalToSuperview().offset(32)
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.centerY.equalToSuperview()
        }
        
        addSubview(tv_project_name)
        tv_project_name.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(10)
            make.left.equalTo(60)
            make.width.equalTo(300)
            make.height.equalTo(13)
        }
        
        addSubview(tv_project_date)
        tv_project_date.snp.makeConstraints { (make) in
            make.top.equalTo(tv_project_name.snp.bottom).offset(2)
            make.left.equalTo(60)
            make.width.equalTo(300)
            make.height.equalTo(13)
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

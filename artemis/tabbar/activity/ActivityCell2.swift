//
//  ActivityCell2.swift
//  artemis
//
//  Created by VF Consulting on 8/5/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit

class ActiityCell2 : UICollectionViewCell {
    
    var item: Task? {
        
        didSet {
            
            if let activity = item?.str_taskname {
                self.tv_activity.text = "\(activity)"
            }
            
            if let project_code = item?.str_project_cod {
                self.tv_project_code.text = "\(project_code)"
            }
            
            if let hours = item?.num_registered_hours, let minutes = item?.num_registered_minutes {
                self.tv_hours.text = "\(hours)h \(minutes)min"
            }
            
            if let date = item?.dte_activitydate {
                self.tv_date.text = date
            }
            
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var iv_icon: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "icon_idea_red")
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    let tv_activity: UITextView = {
        let text = UITextView()
        text.font = UIFont.systemFont(ofSize: 14)
        text.text = "DESARROLLO"
        text.textColor = UIColor.black
        text.textAlignment = .left
        text.contentInset = UIEdgeInsetsMake(-7, 0, 0, 0)
        text.isUserInteractionEnabled = false
        return text
    }()
    
    let tv_project_code: UITextView = {
        let text = UITextView()
        text.font = UIFont.systemFont(ofSize: 12)
        text.text = "PRY032"
        text.textColor = UIColor.darkGray
        text.textAlignment = .left
        text.contentInset = UIEdgeInsetsMake(-7, 0, 0, 0)
        text.isUserInteractionEnabled = false
        return text
    }()
    
    let tv_hours: UITextView = {
        let text = UITextView()
        text.font = UIFont.systemFont(ofSize: 14)
        text.text = "04h 15min"
        text.textColor = UIColor.primaryDarkColor()
        text.textAlignment = .center
        text.contentInset = UIEdgeInsetsMake(-7, 0, 0, 0)
        text.isUserInteractionEnabled = false
        return text
    }()
    
    let tv_date: UITextView = {
        let text = UITextView()
        text.font = UIFont.systemFont(ofSize: 12)
        text.text = "26/06/2018"
        text.textColor = UIColor.darkGray
        text.textAlignment = .center
        text.contentInset = UIEdgeInsetsMake(-7, 0, 0, 0)
        text.isUserInteractionEnabled = false
        return text
    }()
    
    let v_separator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        return view
    }()
    
    func setupViews(){
        
        backgroundColor = UIColor.clear
        
        addSubview(iv_icon)
        iv_icon.snp.makeConstraints { (make) -> Void in
            make.left.equalToSuperview().offset(32)
            make.top.equalToSuperview().offset(35)
            make.width.equalTo(30)
            make.height.equalTo(30)
            make.centerY.equalToSuperview()
        }
        
        addSubview(tv_activity)
        tv_activity.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(30)
            make.left.equalToSuperview().offset(70)
            make.width.equalTo(150)
            make.height.equalTo(20)
        }
        
        addSubview(tv_project_code)
        tv_project_code.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(tv_activity).offset(20)
            make.left.equalToSuperview().offset(70)
            make.width.equalTo(150)
            make.height.equalTo(20)
        }
        
        addSubview(tv_hours)
        tv_hours.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(30)
            make.right.equalToSuperview().offset(-15)
            make.width.equalTo(120)
            make.height.equalTo(20)
        }
        
        addSubview(tv_date)
        tv_date.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(tv_hours).offset(20)
            make.right.equalToSuperview().offset(-15)
            make.width.equalTo(120)
            make.height.equalTo(20)
        }
        
        addSubview(v_separator)
        v_separator.snp.makeConstraints { (make) -> Void in
            make.centerY.equalToSuperview()
            make.top.equalToSuperview().offset(99)
            make.width.equalToSuperview().inset(32)
            make.height.equalTo(1)
            make.centerX.equalToSuperview()
        }
        
    }
    
}

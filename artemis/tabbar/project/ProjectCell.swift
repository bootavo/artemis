//
//  ProjectCell.swift
//  artemis
//
//  Created by VF Consulting on 8/5/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import Foundation
import UIKit

class ProjectCell: UICollectionViewCell {
    
    var item: Project? {
        
        didSet {
            
            /*
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
            }*/
            
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Header
    var v_header: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.navBar()
        return view
    }()
    
    lazy var iv_status: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "ic_circle_green")
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    let tv_project: UITextView = {
        let text = UITextView()
        text.font = UIFont.systemFont(ofSize: 14)
        text.text = "PRY032"
        text.textColor = UIColor.black
        text.textAlignment = .left
        text.contentInset = UIEdgeInsetsMake(-6, 0, 0, 0)
        text.isUserInteractionEnabled = false
        text.backgroundColor = UIColor.navBar()
        return text
    }()
    
    lazy var iv_time: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "ic_time_gray")
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    lazy var iv_search: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "ic_view_gray")
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    lazy var iv_close: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "ic_close_gray")
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    //Content
    var v_content: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    var v_row1: UIView = {
        let view = UIView()
        //view.backgroundColor = UIColor.blue
        return view
    }()
    
    var v_row2: UIView = {
        let view = UIView()
        //view.backgroundColor = UIColor.green
        return view
    }()
    
    var v_row3: UIView = {
        let view = UIView()
        //view.backgroundColor = UIColor.yellow
        return view
    }()
    
    //Row 1
    lazy var iv_project: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "ic_document_red")
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    let tv_project_label: UITextView = {
        let text = UITextView()
        text.font = UIFont.systemFont(ofSize: 14)
        text.text = "NOMBRE"
        text.textColor = UIColor.black
        text.textAlignment = .left
        text.contentInset = UIEdgeInsetsMake(-7, 0, 0, 0)
        text.isUserInteractionEnabled = false
        return text
    }()
    
    let tv_project_name: UITextView = {
        let text = UITextView()
        text.font = UIFont.systemFont(ofSize: 14)
        text.text = "Nombre del Proyecto"
        text.textColor = UIColor.black
        text.textAlignment = .left
        text.contentInset = UIEdgeInsetsMake(-7, 0, 0, 0)
        text.isUserInteractionEnabled = false
        return text
    }()
    
    //Row 2
    lazy var iv_project_date: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "ic_calendar_red")
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    let tv_project_date_label: UITextView = {
        let text = UITextView()
        text.font = UIFont.systemFont(ofSize: 14)
        text.text = "FECHA"
        text.textColor = UIColor.black
        text.textAlignment = .left
        text.contentInset = UIEdgeInsetsMake(-7, 0, 0, 0)
        text.isUserInteractionEnabled = false
        return text
    }()
    
    let tv_project_date: UITextView = {
        let text = UITextView()
        text.font = UIFont.systemFont(ofSize: 14)
        text.text = "Nombre del Proyecto"
        text.textColor = UIColor.black
        text.textAlignment = .left
        text.contentInset = UIEdgeInsetsMake(-7, 0, 0, 0)
        text.isUserInteractionEnabled = false
        return text
    }()
    
    //Row 3
    lazy var iv_project_status: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "ic_check_red")
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    let tv_project_status_label: UITextView = {
        let text = UITextView()
        text.font = UIFont.systemFont(ofSize: 14)
        text.text = "ESTADO"
        text.textColor = UIColor.black
        text.textAlignment = .left
        text.contentInset = UIEdgeInsetsMake(-7, 0, 0, 0)
        text.isUserInteractionEnabled = false
        return text
    }()
    
    let tv_project_status: UITextView = {
        let text = UITextView()
        text.font = UIFont.systemFont(ofSize: 14)
        text.text = "Nombre del Proyecto"
        text.textColor = UIColor.black
        text.textAlignment = .left
        text.contentInset = UIEdgeInsetsMake(-7, 0, 0, 0)
        text.isUserInteractionEnabled = false
        return text
    }()
    
    let v_separator1: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        return view
    }()
    
    let v_separator2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        return view
    }()
    
    func setupViews(){
        
        backgroundColor = UIColor.clear
        
        //Header
        addSubview(v_header)
        v_header.snp.makeConstraints { (make) -> Void in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(38)
        }
        
        v_header.addSubview(iv_status)
        iv_status.snp.makeConstraints { (make) -> Void in
            make.left.equalToSuperview().offset(16)
            make.width.equalTo(14)
            make.height.equalTo(14)
            make.centerY.equalToSuperview()
        }
        
        v_header.addSubview(tv_project)
        tv_project.snp.makeConstraints { (make) -> Void in
            make.left.equalToSuperview().offset(40)
            make.width.equalTo(100)
            make.height.equalTo(20)
            make.centerY.equalToSuperview()
        }
        
        v_header.addSubview(iv_time)
        iv_time.snp.makeConstraints { (make) -> Void in
            make.right.equalToSuperview().offset(-16)
            make.width.equalTo(14)
            make.height.equalTo(14)
            make.centerY.equalToSuperview()
        }
        
        v_header.addSubview(iv_search)
        iv_search.snp.makeConstraints { (make) -> Void in
            make.right.left.equalTo(iv_time).offset(-24)
            make.width.equalTo(14)
            make.height.equalTo(14)
            make.centerY.equalToSuperview()
        }
        
        v_header.addSubview(iv_close)
        iv_close.snp.makeConstraints { (make) -> Void in
            make.right.left.equalTo(iv_search).offset(-24)
            make.width.equalTo(14)
            make.height.equalTo(14)
            make.centerY.equalToSuperview()
        }
        
        //Content
        addSubview(v_content)
        v_content.snp.makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(v_header).offset(38)
            make.width.equalToSuperview()
            make.height.equalTo(112)
        }
        
        v_content.addSubview(v_row1)
        v_row1.snp.makeConstraints { (make) -> Void in
            make.top.equalToSuperview().offset(3)
            make.width.equalToSuperview()
            make.height.equalTo(37)
        }
        
        v_content.addSubview(v_row2)
        v_row2.snp.makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(v_row1).offset(37)
            make.width.equalToSuperview()
            make.height.equalTo(37)
        }
        
        v_content.addSubview(v_row3)
        v_row3.snp.makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(v_row2).offset(37)
            make.width.equalToSuperview()
            make.height.equalTo(37)
        }
        
        //Row 1
        v_row1.addSubview(iv_project)
        iv_project.snp.makeConstraints { (make) -> Void in
            make.left.equalToSuperview().offset(40)
            make.width.equalTo(14)
            make.height.equalTo(14)
            make.centerY.equalToSuperview()
        }
        
        v_row1.addSubview(tv_project_label)
        tv_project_label.snp.makeConstraints { (make) -> Void in
            make.left.equalToSuperview().offset(56)
            make.width.equalTo(100)
            make.height.equalTo(20)
            make.centerY.equalToSuperview()
        }
        
        v_row1.addSubview(tv_project_name)
        tv_project_name.snp.makeConstraints { (make) -> Void in
            make.left.equalToSuperview().offset(150)
            make.width.equalTo(250)
            make.height.equalTo(20)
            make.centerY.equalToSuperview()
        }
        
        //Row 2
        v_row2.addSubview(iv_project_date)
        iv_project_date.snp.makeConstraints { (make) -> Void in
            make.left.equalToSuperview().offset(40)
            make.width.equalTo(14)
            make.height.equalTo(14)
            make.centerY.equalToSuperview()
        }
        
        v_row2.addSubview(tv_project_date_label)
        tv_project_date_label.snp.makeConstraints { (make) -> Void in
            make.left.equalToSuperview().offset(56)
            make.width.equalTo(100)
            make.height.equalTo(20)
            make.centerY.equalToSuperview()
        }
        
        v_row2.addSubview(tv_project_date)
        tv_project_date.snp.makeConstraints { (make) -> Void in
            make.left.equalToSuperview().offset(150)
            make.width.equalTo(250)
            make.height.equalTo(20)
            make.centerY.equalToSuperview()
        }
        
        //Row 3
        v_row3.addSubview(iv_project_status)
        iv_project_status.snp.makeConstraints { (make) -> Void in
            make.left.equalToSuperview().offset(40)
            make.width.equalTo(14)
            make.height.equalTo(14)
            make.centerY.equalToSuperview()
        }
        
        v_row3.addSubview(tv_project_status_label)
        tv_project_status_label.snp.makeConstraints { (make) -> Void in
            make.left.equalToSuperview().offset(56)
            make.width.equalTo(100)
            make.height.equalTo(20)
            make.centerY.equalToSuperview()
        }
        
        v_row3.addSubview(tv_project_status)
        tv_project_status.snp.makeConstraints { (make) -> Void in
            make.left.equalToSuperview().offset(150)
            make.width.equalTo(250)
            make.height.equalTo(20)
            make.centerY.equalToSuperview()
        }
        
        //Separator
        v_content.addSubview(v_separator1)
        v_separator1.snp.makeConstraints { (make) -> Void in
            make.centerY.equalToSuperview()
            make.top.equalToSuperview().offset(37)
            make.width.equalToSuperview().inset(32)
            make.height.equalTo(1)
            make.centerX.equalToSuperview()
        }
        
        v_content.addSubview(v_separator2)
        v_separator2.snp.makeConstraints { (make) -> Void in
            make.centerY.equalToSuperview()
            make.top.equalToSuperview().offset(74)
            make.width.equalToSuperview().inset(32)
            make.height.equalTo(1)
            make.centerX.equalToSuperview()
        }
        
    }
    
}

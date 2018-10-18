//
//  ActivityCell.swift
//  artemis
//
//  Created by VF Consulting on 8/5/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit
import SwipeCellKit
import Toast

class ActiityCell : SwipeCollectionViewCell {
    
    var item: Task? = nil
    var activityView: UIView? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
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
            activityView?.hideToast()
            activityView?.makeToast("\(item?.str_act_description)")
            print("isSelected")
        }else{
            print("isNotSelected")
        }
    }
    
    func updateUI(task: Task, view: UIView){
    
        item = task
        activityView = view
    
        print("task: \(task.num_task_id)")
        
        if let activity = task.str_act_description {
            self.tv_activity.text = "\(activity)"
//            if activity.count >= 24 {
//                updateConstraint()
//            }
        }
        
        if let kind_of_activity = task.str_taskname, let project_code = task.str_project_cod {
            self.tv_project_code.text = "\(kind_of_activity) - \(project_code)"
        }
        
        if let hours = task.num_registered_hours, let minutes = task.num_registered_minutes {
            self.tv_hours.text = "\(hours)h \(minutes)min"
        }
        
        if let date = task.dte_activitydate {
            self.tv_date.text = date
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var iv_icon: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "icon_idea_red")
        imgView.contentMode = .scaleAspectFill
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    let tv_activity: UITextView = {
        let text = UITextView()
        text.font = UIFont.systemFont(ofSize: 12)
        text.text = "DESARROLLO"
        text.textColor = UIColor.black
        text.textAlignment = .left
        text.contentInset = UIEdgeInsetsMake(-7, 0, 0, 0)
        text.isUserInteractionEnabled = false
        text.textContainer.maximumNumberOfLines = 2
        text.setAnchor(width: 0, height: 35)
        text.centerVertically()
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
        
        for subView:UIView in (contentView.subviews){
            subView.removeFromSuperview()
        }
        contentView.contentMode = .scaleAspectFit
        
        contentView.addSubview(iv_icon)
        iv_icon.snp.makeConstraints { (make) -> Void in
            make.left.equalToSuperview().offset(32)
            make.top.equalToSuperview().offset(35)
            make.width.equalTo(30)
            make.height.equalTo(30)
            make.centerY.equalToSuperview()
        }
        
        contentView.addSubview(tv_activity)
        tv_activity.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(20)
            make.left.equalToSuperview().offset(70)
            make.width.equalTo(190)
            make.height.equalTo(35)
        }
        
        contentView.addSubview(tv_project_code)
        tv_project_code.snp.makeConstraints { (make) in
//            make.top.bottom.equalTo(tv_activity).offset(10)
            make.top.equalToSuperview().offset(55)
            make.left.equalToSuperview().offset(70)
            make.width.equalTo(190)
            make.height.equalTo(20)
        }
        
        contentView.addSubview(tv_hours)
        tv_hours.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(30)
            make.right.equalToSuperview().offset(-35)
            make.width.equalTo(80)
            make.height.equalTo(20)
        }
        
        contentView.addSubview(tv_date)
        tv_date.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(tv_hours).offset(20)
            make.right.equalToSuperview().offset(-15)
            make.width.equalTo(120)
            make.height.equalTo(20)
        }
        
        contentView.addSubview(v_separator)
        v_separator.snp.makeConstraints { (make) -> Void in
            make.centerY.equalToSuperview()
            make.top.equalToSuperview().offset(99)
            make.width.equalToSuperview().inset(32)
            make.height.equalTo(1)
            make.centerX.equalToSuperview()
        }
        
    }
    
    func updateConstraint() {
        tv_activity.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(30)
            make.height.equalTo(20)
        }
        
        tv_project_code.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(35)
            make.height.equalTo(20)
        }
        super.updateConstraints()
    }
    
}

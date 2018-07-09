//
//  ActivityView.swift
//  artemis
//
//  Created by Gustavo Tufiño Fernandez on 7/8/18.
//  Copyright © 2018 PatDevelop. All rights reserved.
//

import UIKit

class ActivityView: UIView{
    
    var offSet: Float = -60
    
    var screen: CGRect? = nil
    var screenWidth: CGFloat? = nil
    var screenHeight: CGFloat? = nil
    
    var saveAction: (() -> Void)?
    var doneAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        
        screen = UIScreen.main.bounds
        screenWidth = screen!.size.width
        screenHeight = screen!.size.height
        print("\(screenWidth!)")
        print("\(screenHeight!)")
        
        addSubview(tf_date)
        tf_date.snp.makeConstraints{
            (make) -> Void in
            make.topMargin.equalTo(35)
            make.width.equalToSuperview().offset(offSet)
            make.centerX.equalToSuperview()
        }
        
        addSubview(tf_project)
        tf_project.snp.makeConstraints{
            (make) -> Void in
            make.top.equalTo(tf_date).offset(50)
            make.width.equalToSuperview().offset(offSet)
            make.centerX.equalToSuperview()
        }
        
        addSubview(tf_activity)
        tf_activity.snp.makeConstraints{
            (make) -> Void in
            make.top.equalTo(tf_project).offset(50)
            //make.topMargin.greaterThanOrEqualTo(tf_project).inset(50)
            make.width.equalToSuperview().offset(offSet)
            make.centerX.equalToSuperview()
        }
        
        addSubview(tf_duration)
        tf_duration.snp.makeConstraints{
            (make) -> Void in
            make.top.equalTo(tf_activity).offset(50)
            make.width.equalToSuperview().offset(offSet)
            make.centerX.equalToSuperview()
        }
        
        addSubview(tf_description)
        tf_description.snp.makeConstraints{
            (make) -> Void in
            make.top.equalTo(tf_duration).offset(50)
            make.width.equalToSuperview().offset(offSet)
            make.centerX.equalToSuperview()
        }
        
        addSubview(btn_save)
        btn_save.snp.makeConstraints{
            (make) -> Void in
            make.top.equalTo(tf_description).offset(70)
            make.width.equalToSuperview().offset(offSet)
            make.centerX.equalToSuperview()
        }
        
        addSubview(btn_cancel)
        btn_cancel.snp.makeConstraints{
            (make) -> Void in
            make.top.equalTo(btn_save).offset(50)
            make.width.equalToSuperview().offset(offSet)
            make.centerX.equalToSuperview()
        }
    }
    
    let tf_date: UITextField = {
        let user = UITextField(placeholder: "27/06/2018")
        return user
    }()
    
    let tf_project: UITextField = {
        let user = UITextField(placeholder: "Proyecto")
        return user
    }()
    
    let tf_activity: UITextField = {
        let user = UITextField(placeholder: "Actividad")
        return user
    }()
    
    let tf_duration: UITextField = {
        let user = UITextField(placeholder: "Duración")
        return user
    }()
    
    let tf_description: UITextField = {
        let user = UITextField(placeholder: "Actividad de tarea ...")
        return user
    }()
    
    let btn_save: RoundedButton = {
        let btn = RoundedButton()
        btn.setTitle(title: "GUARDAR", color: UIColor.primaryColor())
        btn.addTarget(self, action: #selector(save), for: .touchUpInside)
        return btn
    }()
    
    let btn_cancel: RoundedSecondButton = {
        let btn = RoundedSecondButton()
        btn.setTitle(title: "CANCELAR", color: UIColor.primaryDarkColor())
        btn.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        return btn
    }()
    
    @objc func save() {
        saveAction?()
        //let homeController = HomeController(collectionViewLayout: UICollectionViewFlowLayout())
        //window?.rootViewController = UINavigationController(rootViewController: homeController)
    }
    
    @objc func cancel() {
        doneAction?()
        //let homeController = HomeController(collectionViewLayout: UICollectionViewFlowLayout())
        //window?.rootViewController = UINavigationController(rootViewController: homeController)
    }
    
}

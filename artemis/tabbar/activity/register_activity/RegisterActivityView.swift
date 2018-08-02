//
//  ActivityView.swift
//  artemis
//
//  Created by Gustavo Tufiño Fernandez on 7/8/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class RegisterActivityView: UIView{
    
    var offSet: Float = -60
    
    var screen: CGRect? = nil
    var screenWidth: CGFloat? = nil
    var screenHeight: CGFloat? = nil
    
    var saveAction: (() -> Void)?
    var doneAction: (() -> Void)?
    
    var getProjectsAction: (() -> Void)?
    var getKindOfActivitiesAction: (() -> Void)?
    var getHoursAction: (() -> Void)?
    var getMinutesAction: (() -> Void)?
    
    private var date: String = ""
    private var datePicker: UIDatePicker?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(gestureRecognizer:)))
        self.addGestureRecognizer(tapGesture)
        
        self.tf_date.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(viewTapped(gestureRecognizer:)))
        
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
        tf_date.inputView = datePicker
        
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
        
        tf_activity.resignFirstResponder()
        self.endEditing(true)
        
        addSubview(v_duration)
        v_duration.snp.makeConstraints{
            (make) -> Void in
            make.top.equalTo(tf_activity).offset(50)
            make.width.equalToSuperview().offset(offSet)
            make.centerX.equalToSuperview()
        }
        
        v_duration.addSubview(tv_duration)
        tv_duration.snp.makeConstraints{
            (make) -> Void in
            make.left.equalTo(v_duration).offset(15)
            make.width.equalTo(80)
            make.height.equalTo(40)
            make.centerY.equalToSuperview()
        }
        
        v_duration.addSubview(v_hour)
        v_hour.snp.makeConstraints{
            (make) -> Void in
            make.width.equalTo(1)
            make.height.equalTo(40)
            make.right.equalTo(tv_duration).offset(-10)
            make.centerY.equalToSuperview()
        }
        
        v_duration.addSubview(tf_hours)
        tf_hours.snp.makeConstraints{
            (make) -> Void in
            make.width.equalTo(100)
            make.height.equalTo(40)
            make.right.equalTo(tv_duration).offset(100)
            make.centerY.equalToSuperview()
        }
        
        v_duration.addSubview(v_minutes)
        v_minutes.snp.makeConstraints{
            (make) -> Void in
            make.width.equalTo(1)
            make.height.equalTo(40)
            make.right.equalTo(tf_hours).offset(-10)
            make.centerY.equalToSuperview()
        }
        
        v_duration.addSubview(tf_minutes)
        tf_minutes.snp.makeConstraints{
            (make) -> Void in
            make.width.equalTo(120)
            make.height.equalTo(40)
            make.right.equalTo(tf_hours).offset(120)
            make.centerY.equalToSuperview()
        }
        
        addSubview(tf_description)
        tf_description.snp.makeConstraints{
            (make) -> Void in
            make.top.equalTo(v_duration).offset(50)
            make.height.equalTo(40)
            make.width.equalToSuperview().offset(offSet)
            make.centerX.equalToSuperview()
        }
        
        addSubview(btn_save)
        btn_save.snp.makeConstraints{
            (make) -> Void in
            make.top.equalTo(tf_description).offset(50)
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
        user.withImage(direction: .Right, image: UIImage(named: "icon_calendar_gray")!, colorSeparator: UIColor.primaryColor(), colorBorder: UIColor.primaryColor())
        user.font = UIFont.systemFont(ofSize: 14)
        return user
    }()
    
    let tf_project: UITextField = {
        let user = UITextField(placeholder: "Proyecto")
        user.withImage(direction: .Right, image: UIImage(named: "ic_drop_down_arrow")!, colorSeparator: UIColor.primaryColor(), colorBorder: UIColor.primaryColor())
        user.addTarget(self, action: #selector(getProjects), for: .touchDown)
        user.font = UIFont.systemFont(ofSize: 14)
        user.isEnabled = true
        return user
    }()
    
    let tf_activity: UITextField = {
        let user = UITextField(placeholder: "Actividad")
        user.withImage(direction: .Right, image: UIImage(named: "ic_drop_down_arrow")!, colorSeparator: UIColor.primaryColor(), colorBorder: UIColor.primaryColor())
        user.addTarget(self, action: #selector(getKindOfActivities), for: .touchDown)
        user.font = UIFont.systemFont(ofSize: 14)
        user.isEnabled = true
        user.inputView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        return user
    }()
    
    let v_duration: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width:  0, height: 40) )
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor.primaryColor()
        view.layer.masksToBounds = true
        view.layer.borderColor = UIColor.placeHolder().cgColor
        view.layer.borderWidth = 1.0
        view.setAnchor(width: 0, height: 40)
        return view
    }()
    
    let tv_duration: UILabel = {
        var tv = UILabel()
        tv.text = "Duracion"
        tv.textColor = UIColor.black
        tv.font = UIFont.systemFont(ofSize: 14)
        tv.textAlignment = .left
        return tv
    }()
    
    let v_hour: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 40))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.placeHolder()
        view.layer.masksToBounds = true
        view.setAnchor(width: 1, height: 40)
        return view
    }()
    
    let v_minutes: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 40))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.placeHolder()
        view.layer.masksToBounds = true
        view.setAnchor(width: 1, height: 40)
        return view
    }()
    
    let tf_hours: UITextField = {
        let user = UITextField()
        
        var placeHolder = NSMutableAttributedString()
        placeHolder = NSMutableAttributedString(attributedString: NSAttributedString(string: "Horas", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.placeHolder() ]))
        user.attributedPlaceholder = placeHolder
        user.setAnchor(width: 0, height: 40)
        user.textAlignment = .left
        
        user.withImage(direction: .Right, image: UIImage(named: "ic_drop_down_arrow")!, colorSeparator: UIColor.primaryColor(), colorBorder: UIColor.primaryColor())
        
        user.addTarget(self, action: #selector(getHours), for: .touchDown)
        user.isEnabled = true
        
        return user
    }()
    
    let tf_minutes: UITextField = {
        let user = UITextField()
        
        var placeHolder = NSMutableAttributedString()
        placeHolder = NSMutableAttributedString(attributedString: NSAttributedString(string: "Minutos", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.placeHolder() ]))
        user.attributedPlaceholder = placeHolder
        user.textAlignment = .left
        
        user.withImage(direction: .Right, image: UIImage(named: "ic_drop_down_arrow")!, colorSeparator: UIColor.primaryColor(), colorBorder: UIColor.primaryColor())
        
        user.addTarget(self, action: #selector(getMinutes), for: .touchDown)
        user.isEnabled = true
        
        return user
    }()
    
    let tf_description: UITextField = {
        let user = UITextField(placeholder: "Actividad de tarea ...")
        user.setAnchor(width: 0, height: 80)
        user.addTarget(self, action: #selector(activateKeyboard), for: .touchDown)
        return user
    }()
    
    let btn_save: RoundedSecondButton = {
        let btn = RoundedSecondButton()
        btn.setTitle(title: "GUARDAR", color: UIColor.primaryColor())
        btn.backgroundColor = UIColor.primaryDarkColor()
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
    
    @objc func getProjects() {
        getProjectsAction?()
    }
    
    @objc func getKindOfActivities() {
        IQKeyboardManager.sharedManager().enableAutoToolbar = false
        getKindOfActivitiesAction?()
    }
    
    @objc func getHours(){
        getHoursAction?()
    }
    
    @objc func getMinutes(){
        getMinutesAction?()
    }
    
    @objc func activateKeyboard(){
        IQKeyboardManager.sharedManager().enableAutoToolbar = true
    }
    
    @objc func dateChanged(datePicker: UIDatePicker){
        let dateFormatterUser = DateFormatter()
        dateFormatterUser.dateFormat = "yyyy/MM/dd"
        date = dateFormatterUser.string(from: datePicker.date)
        self.tf_date.text = date
        
        let dateFormatterServer = DateFormatter()
        dateFormatterServer.dateFormat = "yyyy-MM-dd"
        print("\(dateFormatterServer.string(from: datePicker.date))")
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        self.endEditing(true)
        if date == ""{
            let dateFormatterServer = DateFormatter()
            dateFormatterServer.dateFormat = "yyyy-MM-dd"
            date = dateFormatterServer.string(from: Date())
            self.tf_date.text = date
            print("Not select: \(date)")
        }
    }
    
}

extension UITextField {
    
    enum Direction {
        case Left
        case Right
    }
    
    // add image to textfield
    func withImage(direction: Direction, image: UIImage, colorSeparator: UIColor, colorBorder: UIColor){
        let mainView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 45))
        mainView.layer.cornerRadius = 5
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 45))
        /*view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        view.layer.borderWidth = CGFloat(0.5)
        view.layer.borderColor = colorBorder.cgColor*/
        mainView.addSubview(view)
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 12.0, y: 10.0, width: 24.0, height: 24.0)
        view.addSubview(imageView)
        
        let seperatorView = UIView()
        seperatorView.backgroundColor = colorSeparator
        mainView.addSubview(seperatorView)
        
        if(Direction.Left == direction){ // image left
            seperatorView.frame = CGRect(x: 45, y: 0, width: 5, height: 45)
            self.leftViewMode = .always
            self.leftView = mainView
        } else { // image right
            seperatorView.frame = CGRect(x: 0, y: 0, width: 5, height: 45)
            self.rightViewMode = .always
            self.rightView = mainView
        }
        /*self.layer.borderColor = colorBorder.cgColor
         self.layer.borderWidth = CGFloat(0.5)
         self.layer.cornerRadius = 5*/
        
    }
    
}

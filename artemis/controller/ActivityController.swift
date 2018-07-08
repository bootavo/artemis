//
//  ActivitiesController.swift
//  artemis
//
//  Created by Gustavo Tufiño Fernandez on 7/6/18.
//  Copyright © 2018 PatDevelop. All rights reserved.
//

import UIKit
import SnapKit

class ActivityController: UIViewController, UIApplicationDelegate{
    
    var window2:UIWindow?
    
    var screen: CGRect? = nil
    var screenWidth: CGFloat? = nil
    var screenHeight: CGFloat? = nil
    
    var offSet: Float = -60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ActivityController ---> viewDidLoad()")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ActivityController ---> viewWillAppear()")
        
        //Title Status Bar White
        UIApplication.shared.statusBarStyle = .default //.lightContent
        
        //NavigationBar
        self.navigationController?.isNavigationBarHidden = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Actividades"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = UIColor.title()
        titleLabel.textAlignment = .center
        navigationItem.titleView = titleLabel
        
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        statusBarView.backgroundColor = UIColor.primaryDarkColor()
        view.addSubview(statusBarView)
        
        UIApplication.shared.statusBarStyle = .lightContent //.lightContent
        
        window2 = UIWindow(frame: UIScreen.main.bounds)
        //window2?.makeKeyAndVisible()
        
        let statusBarBackgroundView = UIView()
        statusBarBackgroundView.backgroundColor = UIColor.primaryDarkColor()
        window2?.addSubview(statusBarBackgroundView)
        
        let size:String = ScreenHelper.create().getDevice()
        window2?.addConstraintsWithFormat(format: "H:|[v0]|", views: statusBarBackgroundView)
        window2?.addConstraintsWithFormat(format: "V:|[v0(\(size))]", views: statusBarBackgroundView)
        
        setup()
        setupViews()
    }
    
    func setup(){
        
        //var window2 = UIWindow(frame: UIScreen.main.bounds)
        //window2.makeKeyAndVisible()
        
        view?.backgroundColor = UIColor.primaryColor()
        
        /*
        //StatusBar
        let statusBarBackgroundView = UIView()
        statusBarBackgroundView.backgroundColor = UIColor.primaryDarkColor()
        window.addSubview(statusBarBackgroundView)
        
        //StatusBar Constraints
        let size:String = ScreenHelper.create().getDevice()
        print("\(size)")
        window.addConstraintsWithFormat(format: "H:|[v0]|", views: statusBarBackgroundView)
        window.addConstraintsWithFormat(format: "V:|[v0(\(size))]", views: statusBarBackgroundView)
        */
        
        /*
        var window window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        view?.backgroundColor = UIColor.primaryColor()
        
        //StatusBar
        let statusBarBackgroundView = UIView()
        statusBarBackgroundView.backgroundColor = UIColor.primaryDarkColor()
        window?.addSubview(statusBarBackgroundView)
        
        //StatusBar Constraints
        let size:String = ScreenHelper.create().getDevice()
        print("\(size)")
        window?.addConstraintsWithFormat(format: "H:|[v0]|", views: statusBarBackgroundView)
        window?.addConstraintsWithFormat(format: "V:|[v0(\(size))]", views: statusBarBackgroundView)
        */
        
        
        /*
        //Title Status Bar White
        UIApplication.shared.statusBarStyle = .lightContent //.lightContent
        
        //StatusBar
        let statusBarBackgroundView = UIView()
        statusBarBackgroundView.backgroundColor = UIColor.primaryDarkColor()
        window?.addSubview(statusBarBackgroundView)
        
        //StatusBar Constraints
        let size:String = ScreenHelper.create().getDevice()
        window?.addConstraintsWithFormat(format: "H:|[v0]|", views: statusBarBackgroundView)
        window?.addConstraintsWithFormat(format: "V:|[v0(\(size))]", views: statusBarBackgroundView)
        */
        
        //Get Screen Size
        screen = UIScreen.main.bounds
        screenWidth = screen!.size.width
        screenHeight = screen!.size.height
        print("\(screenWidth!)")
        print("\(screenHeight!)")
    }
    
    func setupViews(){
        self.view.addSubview(tf_date)
        tf_date.snp.makeConstraints{
            (make) -> Void in
            make.topMargin.equalTo(35)
            make.width.equalToSuperview().offset(offSet)
            make.centerX.equalToSuperview()
        }
        
        self.view.addSubview(tf_project)
        tf_project.snp.makeConstraints{
            (make) -> Void in
            make.top.equalTo(tf_date).offset(50)
            make.width.equalToSuperview().offset(offSet)
            make.centerX.equalToSuperview()
        }
        
        self.view.addSubview(tf_activity)
        tf_activity.snp.makeConstraints{
            (make) -> Void in
            make.top.equalTo(tf_project).offset(50)
            //make.topMargin.greaterThanOrEqualTo(tf_project).inset(50)
            make.width.equalToSuperview().offset(offSet)
            make.centerX.equalToSuperview()
        }
        
        self.view.addSubview(tf_duration)
        tf_duration.snp.makeConstraints{
            (make) -> Void in
            make.top.equalTo(tf_activity).offset(50)
            make.width.equalToSuperview().offset(offSet)
            make.centerX.equalToSuperview()
        }
        
        self.view.addSubview(tf_description)
        tf_description.snp.makeConstraints{
            (make) -> Void in
            make.top.equalTo(tf_duration).offset(50)
            make.width.equalToSuperview().offset(offSet)
            make.centerX.equalToSuperview()
        }
        
        self.view.addSubview(btn_save)
        btn_save.snp.makeConstraints{
            (make) -> Void in
            make.top.equalTo(tf_description).offset(70)
            make.width.equalToSuperview().offset(offSet)
            make.centerX.equalToSuperview()
        }
        
        self.view.addSubview(btn_cancel)
        btn_cancel.snp.makeConstraints{
            (make) -> Void in
            make.top.equalTo(btn_save).offset(50)
            make.width.equalToSuperview().offset(offSet)
            make.centerX.equalToSuperview()
        }
        
    }
    
    let tf_date: UITextField = {
        let user = UITextField()
        user.translatesAutoresizingMaskIntoConstraints = false
        user.borderStyle = .none
        user.layer.cornerRadius = 10
        user.backgroundColor = UIColor.primaryColor()
        user.textColor = UIColor.title()
        user.font = UIFont.systemFont(ofSize: 20)
        user.autocorrectionType = .no
        user.layer.masksToBounds = true
        user.layer.borderColor = UIColor.placeHolder().cgColor
        user.layer.borderWidth = 1.0
        
        var paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: user.frame.height))
        user.leftView = paddingView
        user.leftViewMode = UITextFieldViewMode.always
        
        var placeHolder = NSMutableAttributedString()
        placeHolder = NSMutableAttributedString(attributedString: NSAttributedString(string: "27/06/2018", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.placeHolder() ]))
        user.attributedPlaceholder = placeHolder
        user.setAnchor(width: 0, height: 40)
        user.textAlignment = .left
        return user
    }()
    
    let tf_project: UITextField = {
        let user = UITextField()
        user.translatesAutoresizingMaskIntoConstraints = false
        user.borderStyle = .none
        user.layer.cornerRadius = 10
        user.backgroundColor = UIColor.primaryColor()
        user.textColor = UIColor.title()
        user.font = UIFont.systemFont(ofSize: 20)
        user.autocorrectionType = .no
        user.layer.masksToBounds = true
        user.layer.borderColor = UIColor.placeHolder().cgColor
        user.layer.borderWidth = 1.0
        
        var paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: user.frame.height))
        user.leftView = paddingView
        user.leftViewMode = UITextFieldViewMode.always
        
        var placeHolder = NSMutableAttributedString()
        placeHolder = NSMutableAttributedString(attributedString: NSAttributedString(string: "Proyecto", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.placeHolder() ]))
        user.attributedPlaceholder = placeHolder
        user.setAnchor(width: 0, height: 40)
        user.textAlignment = .left
        return user
    }()
    
    let tf_activity: UITextField = {
        let user = UITextField()
        user.translatesAutoresizingMaskIntoConstraints = false
        user.borderStyle = .none
        user.layer.cornerRadius = 10
        user.backgroundColor = UIColor.primaryColor()
        user.textColor = UIColor.title()
        user.font = UIFont.systemFont(ofSize: 20)
        user.autocorrectionType = .no
        user.layer.masksToBounds = true
        user.layer.borderColor = UIColor.placeHolder().cgColor
        user.layer.borderWidth = 1.0
        
        var paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: user.frame.height))
        user.leftView = paddingView
        user.leftViewMode = UITextFieldViewMode.always
        
        var placeHolder = NSMutableAttributedString()
        placeHolder = NSMutableAttributedString(attributedString: NSAttributedString(string: "Actividad", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.placeHolder() ]))
        user.attributedPlaceholder = placeHolder
        user.setAnchor(width: 0, height: 40)
        user.textAlignment = .left
        return user
    }()
    
    let tf_duration: UITextField = {
        let user = UITextField()
        user.translatesAutoresizingMaskIntoConstraints = false
        user.borderStyle = .none
        user.layer.cornerRadius = 10
        user.backgroundColor = UIColor.primaryColor()
        user.textColor = UIColor.title()
        user.font = UIFont.systemFont(ofSize: 20)
        user.autocorrectionType = .no
        user.layer.masksToBounds = true
        user.layer.borderColor = UIColor.placeHolder().cgColor
        user.layer.borderWidth = 1.0
        
        var paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: user.frame.height))
        user.leftView = paddingView
        user.leftViewMode = UITextFieldViewMode.always
        
        var placeHolder = NSMutableAttributedString()
        placeHolder = NSMutableAttributedString(attributedString: NSAttributedString(string: "Usuario", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.placeHolder() ]))
        user.attributedPlaceholder = placeHolder
        user.setAnchor(width: 0, height: 40)
        user.textAlignment = .left
        return user
    }()
    
    let tf_description: UITextField = {
        let user = UITextField()
        user.translatesAutoresizingMaskIntoConstraints = false
        user.borderStyle = .none
        user.layer.cornerRadius = 10
        user.backgroundColor = UIColor.primaryColor()
        user.textColor = UIColor.title()
        user.font = UIFont.systemFont(ofSize: 20)
        user.autocorrectionType = .no
        user.layer.masksToBounds = true
        user.layer.borderColor = UIColor.placeHolder().cgColor
        user.layer.borderWidth = 1.0
        
        var paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: user.frame.height))
        user.leftView = paddingView
        user.leftViewMode = UITextFieldViewMode.always
        
        var placeHolder = NSMutableAttributedString()
        placeHolder = NSMutableAttributedString(attributedString: NSAttributedString(string: "Actividad de tarea ...", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.placeHolder() ]))
        user.attributedPlaceholder = placeHolder
        user.setAnchor(width: 0, height: 40)
        user.textAlignment = .left
        return user
    }()
    
    let btn_save: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let title = NSMutableAttributedString(attributedString: NSAttributedString(string: "GUARDAR", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.primaryColor() ]))
        
        button.setAttributedTitle(title, for: .normal)
        button.backgroundColor = UIColor.primaryDarkColor()
        //button.setTitleColor(UIColor.primaryColor(), for: .normal)
        button.setAnchor(width: 0, height: 40)
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.primaryDarkColor().cgColor
        button.layer.borderWidth = 1
        button.alpha = 1
        button.addTarget(self, action: #selector(save), for: .touchUpInside)
        return button
    }()
    
    let btn_cancel: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let title = NSMutableAttributedString(attributedString: NSAttributedString(string: "CANCELAR", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.primaryDarkColor()]))
        
        button.setAttributedTitle(title, for: .normal)
        button.backgroundColor = UIColor.primaryColor()
        //button.setTitleColor(UIColor.primaryColor(), for: .normal)
        button.setAnchor(width: 0, height: 40)
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.primaryDarkColor().cgColor
        button.layer.borderWidth = 1
        button.alpha = 1
        button.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        return button
    }()
    
    @objc func save() {
        print("save")
        //let homeController = HomeController(collectionViewLayout: UICollectionViewFlowLayout())
        //window?.rootViewController = UINavigationController(rootViewController: homeController)
    }
    
    @objc func cancel() {
        print("cancel")
        //let homeController = HomeController(collectionViewLayout: UICollectionViewFlowLayout())
        //window?.rootViewController = UINavigationController(rootViewController: homeController)
    }
    
}

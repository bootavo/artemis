//
//  LoginView.swift
//  youtube
//
//  Created by Gustavo Tufiño Fernandez on 7/4/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit
import SnapKit
import Toast

class LoginControllerTest: UIViewController, UIApplicationDelegate, UITextFieldDelegate{
    
    var window:UIWindow?
    
    var screen: CGRect? = nil
    var screenWidth: CGFloat? = nil
    var screenHeight: CGFloat? = nil
    
    var offSet: Float = -60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("LoginControllerTest ---> viewDidLoad()")
        setup()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("2. LoginControllerTest ---> viewWillAppear()")
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("3. viewDidAppear()")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("4. viewWillDisappear()")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("5. viewDidDisappear()")
    }
    
    func setup(){
        
        self.navigationController?.isNavigationBarHidden = true
        UIApplication.shared.statusBarStyle = .lightContent //.lightContent
        
        screen = UIScreen.main.bounds
        screenWidth = screen!.size.width
        screenHeight = screen!.size.height
        print("\(screenWidth!)")
        print("\(screenHeight!)")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        if textField == tf_username{
            let limitLength = 25
            guard let text = textField.text else { return true }
            let newLength = text.characters.count + string.characters.count - range.length
            return newLength <= limitLength
        }else if textField == tf_password {
            let limitLength = 20
            guard let text = textField.text else { return true }
            let newLength = text.characters.count + string.characters.count - range.length
            return newLength <= limitLength
        }
        return true
    }
    
    func setupViews(){
        
        self.tf_username.delegate = self
        self.tf_password.delegate = self
        
        self.view.addSubview(iv_background)
        iv_background.snp.makeConstraints{
            (make) -> Void in
            make.edges.equalTo(self.view)
        }
        
        self.view.addSubview(tf_username)
        tf_username.snp.makeConstraints{
            (make) -> Void in
            make.topMargin.equalTo(400)
            make.width.equalToSuperview().offset(offSet)
            make.centerX.equalToSuperview()
        }
        
        self.view.addSubview(tf_password)
        tf_password.snp.makeConstraints{
            (make) -> Void in
            make.top.equalTo(tf_username).offset(50)
            make.width.equalToSuperview().offset(offSet)
            make.centerX.equalToSuperview()
        }
        
        self.view.addSubview(btn_login)
        btn_login.snp.makeConstraints{
            (make) -> Void in
            make.top.equalTo(tf_password).offset(70)
            make.width.equalToSuperview().offset(offSet)
            make.centerX.equalToSuperview()
        }
        
        if ScreenHelper.create().getDevice() == Constants.DEVICE_IPHONE_X{
            self.view.addSubview(powered)
            powered.snp.makeConstraints{ (make) -> Void in
                make.width.equalTo(screenWidth!)
                make.bottom.bottomMargin.equalTo(-20)
            }
        }else {
            self.view.addSubview(powered)
            powered.snp.makeConstraints{ (make) -> Void in
                make.width.equalTo(screenWidth!)
                make.bottom.trailing.equalToSuperview().offset(0)
            }
        }
        
    }
    
    let iv_background: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "bg_login")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let tf_username: UITextField = {
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
        user.autocapitalizationType = .none
        
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
    
    let tf_password: UITextField = {
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
        user.autocapitalizationType = .none
        
        var paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: user.frame.height))
        user.leftView = paddingView
        user.leftViewMode = UITextFieldViewMode.always
        
        var placeHolder = NSMutableAttributedString()
        placeHolder = NSMutableAttributedString(attributedString: NSAttributedString(string: "Contraseña", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.placeHolder() ]))
        user.attributedPlaceholder = placeHolder
        user.setAnchor(width: 0, height: 40)
        user.textAlignment = .left
        return user
    }()
    
    let btn_login: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let title = NSMutableAttributedString(attributedString: NSAttributedString(string: "INICIAR SESIÓN", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.primaryColor() ]))
        
        button.setAttributedTitle(title, for: .normal)
        button.backgroundColor = UIColor.primaryDarkColor()
        //button.setTitleColor(UIColor.primaryColor(), for: .normal)
        button.setAnchor(width: 0, height: 40)
        button.layer.cornerRadius = 0.5 * 40
        button.layer.borderColor = UIColor.primaryDarkColor().cgColor
        button.layer.borderWidth = 1
        button.alpha = 1
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        return button
    }()
    
    let powered: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let title = NSMutableAttributedString(attributedString: NSAttributedString(string: "Una app de VF Consulting", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.primaryColor() ]))
        
        button.setAttributedTitle(title, for: .normal)
        button.backgroundColor = UIColor.primaryDarkColor()
        //button.setTitleColor(UIColor.primaryColor(), for: .normal)
        button.layer.borderColor = UIColor.primaryDarkColor().cgColor
        button.layer.borderWidth = 1
        button.alpha = 1
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        return button
    }()
    
    @objc func login() {
        print("login")
        
        //window = UIWindow(frame: UIScreen.main.bounds)
        //window?.makeKeyAndVisible()
        if verifyLogin(){
            let activityController = ActivityController()
            self.navigationController?.pushViewController(activityController, animated: true)
        }
        //window?.rootViewController = UINavigationController(rootViewController: activityController)
    }
    
    func verifyLogin() -> Bool{
        if tf_username.text != "" || tf_password.text != "" {
            print("Go")
            return true
        }else {
            print("Complete sus datos")
            return false
        }
    }
    
}
